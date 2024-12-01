//===-- RegAllocAco.cpp - Aco Register Allocator ----------------------===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file defines the RAAco function pass, which provides a minimal
// implementation of the aco register allocator.
//
//===----------------------------------------------------------------------===//

#include "AllocationOrder.h"
#include "RegAllocBase.h"
#include "llvm/Analysis/AliasAnalysis.h"
#include "llvm/Analysis/ProfileSummaryInfo.h"
#include "llvm/CodeGen/CalcSpillWeights.h"
#include "llvm/CodeGen/LiveDebugVariables.h"
#include "llvm/CodeGen/LiveIntervals.h"
#include "llvm/CodeGen/LiveRangeEdit.h"
#include "llvm/CodeGen/LiveRegMatrix.h"
#include "llvm/CodeGen/LiveStacks.h"
#include "llvm/CodeGen/MachineBlockFrequencyInfo.h"
#include "llvm/CodeGen/MachineFunctionPass.h"
#include "llvm/CodeGen/MachineLoopInfo.h"
#include "llvm/CodeGen/Passes.h"
#include "llvm/CodeGen/RegAllocRegistry.h"
#include "llvm/CodeGen/Spiller.h"
#include "llvm/CodeGen/TargetRegisterInfo.h"
#include "llvm/CodeGen/VirtRegMap.h"
#include "llvm/Pass.h"
#include "llvm/Support/Debug.h"
#include "llvm/Support/raw_ostream.h"
#include <queue>
#include <sstream>
#include <boost/pending/disjoint_sets.hpp>
#include <unordered_set>

using namespace llvm;

#define DEBUG_TYPE "regalloc"

static RegisterRegAlloc acoRegAlloc("aco", "aco register allocator",
                                      createAcoRegisterAllocator);

namespace {
  struct CompSpillWeight {
    bool operator()(const LiveInterval *A, const LiveInterval *B) const {
      return A->weight() < B->weight();
    }
  };
}

using ACOColoringResult = std::map<LiveInterval*, std::optional<MCRegister>>;
using Graph = std::vector<std::vector<bool>>;
using ColorOptions = std::vector<std::vector<bool>>;

namespace {
  Graph makeEmptyGraph(unsigned int n) {
    return std::vector<std::vector<bool>>(n, std::vector<bool>(n, false));
  }

  void printGraph(const Graph &graph) {
    LLVM_DEBUG(dbgs() << "Interference graph\n");
    for(const auto &row : graph) {
      for(bool v : row) {
        LLVM_DEBUG(dbgs() << (v ? 1 : 0) << " ");
      }
      LLVM_DEBUG(dbgs() << "\n");
    }
  }
}

namespace {
/// RAAco provides a minimal implementation of the aco register allocation
/// algorithm. It prioritizes live virtual registers by spill weight and spills
/// whenever a register is unavailable. This is not practical in production but
/// provides a useful baseline both for measuring other allocators and comparing
/// the speed of the aco algorithm against other styles of allocators.
class RAAco : public MachineFunctionPass,
                public RegAllocBase,
                private LiveRangeEdit::Delegate {
  // context
  MachineFunction *MF = nullptr;

  // state
  std::unique_ptr<Spiller> SpillerInstance;
  std::priority_queue<const LiveInterval *, std::vector<const LiveInterval *>,
                      CompSpillWeight>
      Queue;

  // Scratch space.  Allocated here to avoid repeated malloc calls in
  // selectOrSplit().
  BitVector UsableRegs;

  std::unordered_map<int, std::unordered_set<MCPhysReg>> colorsToRegs{};
  std::unordered_map<MCPhysReg, int> regsToColors{};

  bool LRE_CanEraseVirtReg(Register) override;
  void LRE_WillShrinkVirtReg(Register) override;

public:
  RAAco(const RegAllocFilterFunc F = nullptr);

  /// Return the pass name.
  StringRef getPassName() const override { return "Aco Register Allocator"; }

  /// RAAco analysis usage.
  void getAnalysisUsage(AnalysisUsage &AU) const override;

  void releaseMemory() override;

  Spiller &spiller() override { return *SpillerInstance; }

  void enqueueImpl(const LiveInterval *LI) override { Queue.push(LI); }

  const LiveInterval *dequeue() override {
    if (Queue.empty())
      return nullptr;
    const LiveInterval *LI = Queue.top();
    Queue.pop();
    return LI;
  }

  MCRegister selectOrSplit(const LiveInterval &VirtReg,
                           SmallVectorImpl<Register> &SplitVRegs) override;

  /// Perform register allocation.
  bool runOnMachineFunction(MachineFunction &mf) override;

  MachineFunctionProperties getRequiredProperties() const override {
    return MachineFunctionProperties().set(
        MachineFunctionProperties::Property::NoPHIs);
  }

  MachineFunctionProperties getClearedProperties() const override {
    return MachineFunctionProperties().set(
      MachineFunctionProperties::Property::IsSSA);
  }

  // Helper for spilling all live virtual registers currently unified under preg
  // that interfere with the most recently queried lvr.  Return true if spilling
  // was successful, and append any new spilled/split intervals to splitLVRs.
  bool spillInterferences(const LiveInterval &VirtReg, MCRegister PhysReg,
                          SmallVectorImpl<Register> &SplitVRegs);

  /* ACO */
  Graph makeGraph();
  ColorOptions makeColorOptions();
  ACOColoringResult doACOColoring();
  // Returns true if a register was spilled, false otherwise
  bool allocateACOColors(const ACOColoringResult& coloring);
  bool isValidPhysReg(MCRegister physReg, LiveInterval* virtReg);
  void createColors();
  MCPhysReg getRegisterFromColor(int color, TargetRegisterClass* rc);

  static char ID;
};

char RAAco::ID = 0;

} // end anonymous namespace

char &llvm::RAAcoID = RAAco::ID;

INITIALIZE_PASS_BEGIN(RAAco, "regallocaco", "Aco Register Allocator",
                      false, false)
INITIALIZE_PASS_DEPENDENCY(LiveDebugVariables)
INITIALIZE_PASS_DEPENDENCY(SlotIndexesWrapperPass)
INITIALIZE_PASS_DEPENDENCY(LiveIntervalsWrapperPass)
INITIALIZE_PASS_DEPENDENCY(RegisterCoalescer)
INITIALIZE_PASS_DEPENDENCY(MachineScheduler)
INITIALIZE_PASS_DEPENDENCY(LiveStacks)
INITIALIZE_PASS_DEPENDENCY(AAResultsWrapperPass)
INITIALIZE_PASS_DEPENDENCY(MachineDominatorTreeWrapperPass)
INITIALIZE_PASS_DEPENDENCY(MachineLoopInfoWrapperPass)
INITIALIZE_PASS_DEPENDENCY(VirtRegMapWrapperLegacy)
INITIALIZE_PASS_DEPENDENCY(LiveRegMatrixWrapperLegacy)
INITIALIZE_PASS_DEPENDENCY(ProfileSummaryInfoWrapperPass)
INITIALIZE_PASS_END(RAAco, "regallocaco", "Aco Register Allocator", false,
                    false)

bool RAAco::LRE_CanEraseVirtReg(Register VirtReg) {
  LiveInterval &LI = LIS->getInterval(VirtReg);
  if (VRM->hasPhys(VirtReg)) {
    Matrix->unassign(LI);
    aboutToRemoveInterval(LI);
    return true;
  }
  // Unassigned virtreg is probably in the priority queue.
  // RegAllocBase will erase it after dequeueing.
  // Nonetheless, clear the live-range so that the debug
  // dump will show the right state for that VirtReg.
  LI.clear();
  return false;
}

void RAAco::LRE_WillShrinkVirtReg(Register VirtReg) {
  if (!VRM->hasPhys(VirtReg))
    return;

  // Register is assigned, put it back on the queue for reassignment.
  LiveInterval &LI = LIS->getInterval(VirtReg);
  Matrix->unassign(LI);
  enqueue(&LI);
}

RAAco::RAAco(RegAllocFilterFunc F)
    : MachineFunctionPass(ID), RegAllocBase(F) {}

void RAAco::getAnalysisUsage(AnalysisUsage &AU) const {
  AU.setPreservesCFG();
  AU.addRequired<AAResultsWrapperPass>();
  AU.addPreserved<AAResultsWrapperPass>();
  AU.addRequired<LiveIntervalsWrapperPass>();
  AU.addPreserved<LiveIntervalsWrapperPass>();
  AU.addPreserved<SlotIndexesWrapperPass>();
  AU.addRequired<LiveDebugVariables>();
  AU.addPreserved<LiveDebugVariables>();
  AU.addRequired<LiveStacks>();
  AU.addPreserved<LiveStacks>();
  AU.addRequired<ProfileSummaryInfoWrapperPass>();
  AU.addRequired<MachineBlockFrequencyInfoWrapperPass>();
  AU.addPreserved<MachineBlockFrequencyInfoWrapperPass>();
  AU.addRequiredID(MachineDominatorsID);
  AU.addPreservedID(MachineDominatorsID);
  AU.addRequired<MachineLoopInfoWrapperPass>();
  AU.addPreserved<MachineLoopInfoWrapperPass>();
  AU.addRequired<VirtRegMapWrapperLegacy>();
  AU.addPreserved<VirtRegMapWrapperLegacy>();
  AU.addRequired<LiveRegMatrixWrapperLegacy>();
  AU.addPreserved<LiveRegMatrixWrapperLegacy>();
  MachineFunctionPass::getAnalysisUsage(AU);
}

void RAAco::releaseMemory() {
  SpillerInstance.reset();
}


// Spill or split all live virtual registers currently unified under PhysReg
// that interfere with VirtReg. The newly spilled or split live intervals are
// returned by appending them to SplitVRegs.
bool RAAco::spillInterferences(const LiveInterval &VirtReg,
                                 MCRegister PhysReg,
                                 SmallVectorImpl<Register> &SplitVRegs) {
  // Record each interference and determine if all are spillable before mutating
  // either the union or live intervals.
  SmallVector<const LiveInterval *, 8> Intfs;

  // Collect interferences assigned to any alias of the physical register.
  for (MCRegUnit Unit : TRI->regunits(PhysReg)) {
    LiveIntervalUnion::Query &Q = Matrix->query(VirtReg, Unit);
    for (const auto *Intf : reverse(Q.interferingVRegs())) {
      if (!Intf->isSpillable() || Intf->weight() > VirtReg.weight())
        return false;
      Intfs.push_back(Intf);
    }
  }
  LLVM_DEBUG(dbgs() << "spilling " << printReg(PhysReg, TRI)
                    << " interferences with " << VirtReg << "\n");
  assert(!Intfs.empty() && "expected interference");

  // Spill each interfering vreg allocated to PhysReg or an alias.
  for (const LiveInterval *Spill : Intfs) {
    // Skip duplicates.
    if (!VRM->hasPhys(Spill->reg()))
      continue;

    // Deallocate the interfering vreg by removing it from the union.
    // A LiveInterval instance may not be in a union during modification!
    Matrix->unassign(*Spill);

    // Spill the extracted interval.
    LiveRangeEdit LRE(Spill, SplitVRegs, *MF, *LIS, VRM, this, &DeadRemats);
    spiller().spill(LRE);
  }
  return true;
}

// Driver for the register assignment and splitting heuristics.
// Manages iteration over the LiveIntervalUnions.
//
// This is a minimal implementation of register assignment and splitting that
// spills whenever we run out of registers.
//
// selectOrSplit can only be called once per live virtual register. We then do a
// single interference test for each register the correct class until we find an
// available register. So, the number of interference tests in the worst case is
// |vregs| * |machineregs|. And since the number of interference tests is
// minimal, there is no value in caching them outside the scope of
// selectOrSplit().
MCRegister RAAco::selectOrSplit(const LiveInterval &VirtReg,
                                  SmallVectorImpl<Register> &SplitVRegs) {
  // Populate a list of physical register spill candidates.
  SmallVector<MCRegister, 8> PhysRegSpillCands;

  // Check for an available register in this class.
  auto Order =
      AllocationOrder::create(VirtReg.reg(), *VRM, RegClassInfo, Matrix);
  for (MCRegister PhysReg : Order) {
    assert(PhysReg.isValid());
    // Check for interference in PhysReg
    switch (Matrix->checkInterference(VirtReg, PhysReg)) {
    case LiveRegMatrix::IK_Free:
      // PhysReg is available, allocate it.
      return PhysReg;

    case LiveRegMatrix::IK_VirtReg:
      // Only virtual registers in the way, we may be able to spill them.
      PhysRegSpillCands.push_back(PhysReg);
      continue;

    default:
      // RegMask or RegUnit interference.
      continue;
    }
  }

  // Try to spill another interfering reg with less spill weight.
  for (MCRegister &PhysReg : PhysRegSpillCands) {
    if (!spillInterferences(VirtReg, PhysReg, SplitVRegs))
      continue;

    assert(!Matrix->checkInterference(VirtReg, PhysReg) &&
           "Interference after spill.");
    // Tell the caller to allocate to this newly freed physical register.
    return PhysReg;
  }

  // No other spill candidates were found, so spill the current VirtReg.
  LLVM_DEBUG(dbgs() << "spilling: " << VirtReg << '\n');
  if (!VirtReg.isSpillable())
    return ~0u;
  LiveRangeEdit LRE(&VirtReg, SplitVRegs, *MF, *LIS, VRM, this, &DeadRemats);
  spiller().spill(LRE);

  // The live virtual register requesting allocation was spilled, so tell
  // the caller not to allocate anything during this round.
  return 0;
}

Graph RAAco::makeGraph() {
  unsigned int numVirtRegs = MRI->getNumVirtRegs();  
  Graph graph = makeEmptyGraph(numVirtRegs);

  for (unsigned i = 0; i < numVirtRegs; ++i) {
    Register Reg1 = Register::index2VirtReg(i);
    if (LIS->hasInterval(Reg1)) {
      LLVM_DEBUG(dbgs() << printReg(Reg1, TRI) << "\n");
    }
    if (MRI->reg_nodbg_empty(Reg1) || !LIS->hasInterval(Reg1))
      continue;
    for (unsigned j = 0; j < numVirtRegs; ++j) {
      if (i == j) {
        continue;
      }

      Register Reg2 = Register::index2VirtReg(j);
      if (MRI->reg_nodbg_empty(Reg2) || !LIS->hasInterval(Reg1))
        continue;
      if(LIS->getInterval(Reg1).overlaps(LIS->getInterval(Reg2))) {
        graph[i][j] = true;
      }
    }
  }

  return graph;
}

void RAAco::createColors() {
  const int num_elements = TRI->getNumRegUnits();

  std::vector<int> rank(num_elements, 0);
  std::vector<int> parent(num_elements);

  for (int i = 0; i < num_elements; ++i) {
    parent[i] = i;
  }

  boost::disjoint_sets<int*, int*> ds(&rank[0], &parent[0]);

  for (int i = 0; i < num_elements; ++i) {
    ds.make_set(i);
  }

  std::set<MCPhysReg> usedRegs{};

  for (unsigned i = 0; i < MRI->getNumVirtRegs(); ++i) {
    Register virtReg = Register::index2VirtReg(i);
    if (LIS->hasInterval(virtReg) && !MRI->reg_nodbg_empty(virtReg)) {
      const TargetRegisterClass *rc = MRI->getRegClass(virtReg);
      for (MCPhysReg reg : *rc) {
        usedRegs.insert(reg);
      }
    }
  }

  for (MCPhysReg reg : usedRegs) {
    auto regUnits = TRI->regunits(reg);
    auto firstUnit = *regUnits.begin();

    for (auto regUnit : regUnits) {
      ds.union_set(firstUnit, regUnit);
    }
  }

  int currentColor = 0;
  std::unordered_map<int, int> representative_to_color{};

  for (MCPhysReg reg : usedRegs) {
    auto unit = *TRI->regunits(reg).begin();
    int representative = ds.find_set(unit);

    if (representative_to_color.count(representative) == 0) {
      representative_to_color[representative] = currentColor;
      regsToColors[reg] = currentColor;
      currentColor++;
    } else {
      regsToColors[reg] = representative_to_color[representative];
    }
  }

  for (auto &[reg, color] : regsToColors) {
    errs() << TRI->getName(reg) << " = " << color << "\n";
    colorsToRegs[color].insert(reg);
  }
}

ColorOptions RAAco::makeColorOptions() {
  int numVirtRegs = MRI->getNumVirtRegs();

  ColorOptions colorOptions(numVirtRegs, std::vector<bool>(colorsToRegs.size(), false));

  for(int i = 0; i < numVirtRegs; ++i) {
    Register vr = Register::index2VirtReg(i);
    if (MRI->reg_nodbg_empty(vr) || !LIS->hasInterval(vr)) {
      colorOptions[i][0] = true;
      continue;
    }
    const TargetRegisterClass *rc = MRI->getRegClass(vr);
    ArrayRef<MCPhysReg> allocOrder = RegClassInfo.getOrder(rc);  
    for (auto reg : allocOrder) {
      auto interference = Matrix->checkInterference(LIS->getInterval(vr), reg);
      if(interference == LiveRegMatrix::InterferenceKind::IK_Free) {
        colorOptions[i][regsToColors[reg]] = true;
      }
    }
  }

  return colorOptions;
}

MCPhysReg RAAco::getRegisterFromColor(int color, TargetRegisterClass* rc) {
  auto& regs = colorsToRegs[color];
  for (MCPhysReg reg : regs) {
    if (rc->contains(reg)) {
      return reg;
    }
  }
}

ACOColoringResult RAAco::doACOColoring() {
  // TODO: actually integrate with coloring implementation

  // output of coloring, index is VR #, value is physical reg number (color)
  std::vector<int> colors{216, 239, -1, 267, 217, 218, 219, 220};
//  std::vector<int> colors{208, 240, -1, 247, 217, 216, 217, 208}; // correct

  ACOColoringResult coloring{};

  // convert output of ACO to useful format for actual allocation
  for (unsigned int i = 0; i < colors.size(); ++i) {
    Register r{Register::index2VirtReg(i)};
    if (MRI->reg_nodbg_empty(r) || !LIS->hasInterval(r)) {
      LLVM_DEBUG(dbgs() << "Encountered unused virtual reg in aco graph: " << r << '\n');
      continue; // is this ok, to just exclude it?
    }

    LiveInterval* virtReg{&LIS->getInterval(r)};

    std::optional<MCPhysReg> physReg{std::nullopt};
    if (colors[i] >= 0) {
      // negative color will indicate a spill
      physReg = MCRegister{static_cast<MCPhysReg>(colors[i])};
    }

    coloring[virtReg] = physReg;
  }

  return coloring;
}

bool RAAco::isValidPhysReg(MCRegister physReg, LiveInterval* virtReg) {
  const TargetRegisterClass *rc = MRI->getRegClass(virtReg->reg());
  ArrayRef<MCPhysReg> allocOrder = RegClassInfo.getOrder(rc);


  LLVM_DEBUG(dbgs() << "Enumerating valid physical regs for VR " << Register::virtReg2Index(virtReg->reg()) << ": ");

  for (auto reg : allocOrder) {
    LLVM_DEBUG(dbgs() << reg << ", ");
    if (reg == physReg) {
      LLVM_DEBUG(dbgs() << "<-- Found!\n");
      return true;
    }
  }

  LLVM_DEBUG(dbgs() << "; Not Found!\n");
  return false;
}

bool RAAco::allocateACOColors(const ACOColoringResult& coloring) {
  bool spilled{false};
  for (unsigned int i = 0; i < MRI->getNumVirtRegs(); ++i) {
    LLVM_DEBUG(dbgs() << "** VIRTUAL REGISTER " << i << " **\n");
    Register vr{Register::index2VirtReg(i)};
    const TargetRegisterClass *rc = MRI->getRegClass(vr);
    ArrayRef<MCPhysReg> allocOrder = RegClassInfo.getOrder(rc);

    for (auto reg : allocOrder) {
      LLVM_DEBUG(dbgs() << reg << " ");
    }
    LLVM_DEBUG(dbgs() << "\n");
  }

  LLVM_DEBUG(dbgs() << "REG UNITS FOR W0: ");
  for (auto unit : TRI->regunits(208)) {
    LLVM_DEBUG(dbgs() << unit << " ");
  }
  LLVM_DEBUG(dbgs() << "\n");

  for (const auto&[virtReg, physReg] : coloring) {
    if (physReg.has_value()) {
      // extra check for valid reg
//      if (!isValidPhysReg(*physReg, virtReg)) {
//        errs() << "Invalid physical register (" << *physReg << ") for VR ("
//               << Register::virtReg2Index(virtReg->reg())
//               << ") was in coloring output!\n";
//      }

//      VRM->assignVirt2Phys(virtReg->reg(), *physReg);
      LLVM_DEBUG(dbgs() << "Interference?: " << static_cast<int>(Matrix->checkInterference(*virtReg, *physReg)) << "\n");
      Matrix->assign(*virtReg, *physReg);
      // TODO: if we do end up using the matrix, use this INSTEAD of the above call
      //      Matrix->assign(*virtReg, *physReg);
    } else {
      // need to spill
      spilled = true;
      //      Matrix->unassign(*virtReg);
      // TODO: figure out how to use LRE + Spiller
    }
  }

  return spilled;
}

bool RAAco::runOnMachineFunction(MachineFunction &mf) {
  LLVM_DEBUG(dbgs() << "********** ACO REGISTER ALLOCATION **********\n"
                    << "********** Function: " << mf.getName() << '\n');

  MF = &mf;
  RegAllocBase::init(getAnalysis<VirtRegMapWrapperLegacy>().getVRM(),
                     getAnalysis<LiveIntervalsWrapperPass>().getLIS(),
                     getAnalysis<LiveRegMatrixWrapperLegacy>().getLRM());
  VirtRegAuxInfo VRAI(
      *MF, *LIS, *VRM, getAnalysis<MachineLoopInfoWrapperPass>().getLI(),
      getAnalysis<MachineBlockFrequencyInfoWrapperPass>().getMBFI(),
      &getAnalysis<ProfileSummaryInfoWrapperPass>().getPSI());
  VRAI.calculateSpillWeightsAndHints();

  SpillerInstance.reset(createInlineSpiller(*this, *MF, *VRM, VRAI));

  // ACO Register Allocation
  bool spillsOccurred{false};
  ACOColoringResult coloring;

  createColors();
  ColorOptions options = makeColorOptions();

  for (auto& row : options) {
    for (bool el : row) {
      errs() << el << " ";
    }
    errs() << "\n";
  }

//  for (unsigned int reg = 1; reg < TRI->getNumRegs(); ++reg) {
//    errs() << "Register " << TRI->getName(reg) << " -> ";
//    for (auto regUnit : TRI->regunits(reg)) {
//      errs() << regUnit << ", ";
//    }
//
//    errs() << "\n";
//  }

  Graph graph = makeGraph();
  printGraph(graph);

  do {
    coloring = doACOColoring();
    spillsOccurred = allocateACOColors(coloring);
    break; // TODO: remove so we actually re-build and re-color graph after spilling
  } while (spillsOccurred);

  postOptimization();

  // Diagnostic output before rewriting
  LLVM_DEBUG(dbgs() << "Post alloc VirtRegMap:\n" << *VRM << "\n");

  releaseMemory();
  return true;
}

FunctionPass* llvm::createAcoRegisterAllocator() {
  return new RAAco();
}

FunctionPass *llvm::createAcoRegisterAllocator(RegAllocFilterFunc F) {
  return new RAAco(F);
}
