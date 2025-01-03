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
#include <boost/pending/disjoint_sets.hpp>
#include <chrono>
#include <queue>
#include <sstream>
#include <unordered_set>

#include "RegAllocACO.h"
#include "ACOGraphColoring.h"

using namespace llvm;

#define DEBUG_TYPE "regalloc_aco"

static cl::opt<double> Alpha("aco-alpha", cl::desc("Alpha parameter"),
                             cl::init(3.0));

static cl::opt<double> Beta("aco-beta", cl::desc("Beta parameter"),
                            cl::init(16.0));

static cl::opt<double> Rho("aco-rho", cl::desc("Evaporation rate (rho)"),
                           cl::init(0.7));

static cl::opt<double> MaxTime("aco-max-time",
                               cl::desc("Maximum execution time (seconds)"),
                               cl::init(100.0));

static cl::opt<double>
    MaxTabucolTime("aco-max-tabucol-time",
                   cl::desc("Maximum Tabucol execution time (seconds)"),
                   cl::init(0.1));

static cl::opt<int> MaxCycles("aco-max-cycles",
                              cl::desc("Maximum number of cycles"),
                              cl::init(625));

static cl::opt<int> MaxTabucolCycles("aco-max-tabucol-cycles",
                                     cl::desc("Maximum Tabucol cycles"),
                                     cl::init(25));

static cl::opt<int> NumAnts("aco-num-ants", cl::desc("Number of ants"),
                            cl::init(80));

static cl::opt<int>
    Gap("aco-gap", cl::desc("Cycle gap (suggested: sqrt of aco-max-cycles)"),
        cl::init(25));

static cl::opt<double>
    SpillCostImportance("aco-spill-cost-importance", cl::desc("Spill cost importance"),
        cl::init(0));

static RegisterRegAlloc acoRegAlloc("aco", "aco register allocator",
                                    createAcoRegisterAllocator);

namespace {

Graph makeEmptyGraph(unsigned int n) {
  return std::vector<std::vector<bool>>(n, std::vector<bool>(n, false));
}

void printGraph(const Graph &graph) {
  LLVM_DEBUG(dbgs() << "Interference graph\n");
  for (const auto &row : graph) {
    for (bool v : row) {
      LLVM_DEBUG(dbgs() << (v ? 1 : 0) << " ");
    }
    LLVM_DEBUG(dbgs() << "\n");
  }
}

}

char RAAco::ID = 0;
char &llvm::RAAcoID = RAAco::ID;

INITIALIZE_PASS_BEGIN(RAAco, "regallocaco", "Aco Register Allocator", false,
                      false)
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

RAAco::RAAco(RegAllocFilterFunc F) : MachineFunctionPass(ID), RegAllocBase(F) {}

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

void RAAco::releaseMemory() { SpillerInstance.reset(); }

std::vector<unsigned int> RAAco::makeVirtualRegsList() {
  unsigned int numTotalVirtRegs = MRI->getNumVirtRegs();
  std::vector<unsigned int> virtualRegs;
  for (unsigned i = 0; i < numTotalVirtRegs; ++i) {
    Register Reg1 = Register::index2VirtReg(i);
    if (MRI->reg_nodbg_empty(Reg1) || !LIS->hasInterval(Reg1)) {
      continue;
    }
    virtualRegs.push_back(i);
  }
  return virtualRegs;
}

Graph RAAco::makeGraph(const std::vector<unsigned int> &virtualRegs) {
  Graph graph = makeEmptyGraph(virtualRegs.size());

  for (size_t i = 0; i < virtualRegs.size(); ++i) {
    Register Reg1 = Register::index2VirtReg(virtualRegs[i]);
    for (size_t j = 0; j < virtualRegs.size(); ++j) {
      if (i == j) {
        continue;
      }

      Register Reg2 = Register::index2VirtReg(virtualRegs[j]);

      if (LIS->getInterval(Reg1).empty() || LIS->getInterval(Reg2).empty()) {
        graph[i][j] = false;
        continue;
      }
      if (LIS->getInterval(Reg1).overlaps(LIS->getInterval(Reg2))) {
        graph[i][j] = true;
      }
    }
  }

  return graph;
}

RAAco::ColorMappings RAAco::createColorMappings(const std::vector<unsigned int> &virtualRegs) {
  RAAco::ColorMappings mappings;

  const int num_elements = TRI->getNumRegUnits();

  std::vector<int> rank(num_elements, 0);
  std::vector<int> parent(num_elements);

  for (int i = 0; i < num_elements; ++i) {
    parent[i] = i;
  }

  boost::disjoint_sets<int *, int *> ds(&rank[0], &parent[0]);

  for (int i = 0; i < num_elements; ++i) {
    ds.make_set(i);
  }

  std::set<MCPhysReg> usedRegs{};

  for (unsigned int i : virtualRegs) {
    Register virtReg = Register::index2VirtReg(i);
    if (LIS->hasInterval(virtReg) && !MRI->reg_nodbg_empty(virtReg)) {
      const TargetRegisterClass *rc = MRI->getRegClass(virtReg);
      ArrayRef<MCPhysReg> allocOrder = RegClassInfo.getOrder(rc);

      for (MCPhysReg reg : allocOrder) {
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
      mappings.regsToColors[reg] = currentColor;
      currentColor++;
    } else {
      mappings.regsToColors[reg] = representative_to_color[representative];
    }
  }

  for (auto &[reg, color] : mappings.regsToColors) {
    LLVM_DEBUG(dbgs() << TRI->getName(reg) << " = " << color << "\n");
    mappings.colorsToRegs[color].insert(reg);
  }
  
  return mappings;
}

ColorOptions RAAco::makeColorOptions(const std::vector<unsigned int> &virtualRegs, const ColorMappings &colorMappings) {
  ColorOptions colorOptions(virtualRegs.size(),
                            std::vector<bool>(getNumberOfColors(colorMappings), false));

  for (size_t i = 0; i < virtualRegs.size(); ++i) {
    Register vr = Register::index2VirtReg(virtualRegs[i]);
    const TargetRegisterClass *rc = MRI->getRegClass(vr);
    ArrayRef<MCPhysReg> allocOrder = RegClassInfo.getOrder(rc);
    for (auto reg : allocOrder) {
      auto interference = Matrix->checkInterference(LIS->getInterval(vr), reg);
      if (interference == LiveRegMatrix::InterferenceKind::IK_Free) {
        colorOptions[i][getColorFromPhyReg(colorMappings, reg)] = true;
      }
    }
  }

  return colorOptions;
}

int RAAco::getNumberOfColors(const ColorMappings &mappings) {
  return mappings.colorsToRegs.size();
}

MCPhysReg RAAco::getColorFromPhyReg(const ColorMappings &mappings, MCPhysReg physReg) {
  return mappings.regsToColors.at(physReg);
}


MCPhysReg RAAco::getPhyRegFromColor(const ColorMappings &mappings, int color,
                                      const TargetRegisterClass *rc) {
  auto &regs = mappings.colorsToRegs.at(color);
  for (MCPhysReg reg : regs) {
    if (rc->contains(reg)) {
      return reg;
    }
  }
  llvm_unreachable("Every color should have some register");
}

bool RAAco::handleForcedSpills(ColorOptions &options, const std::vector<unsigned int> &virtualRegs) {
  std::vector<unsigned int> mustSpill;
  for (size_t i = 0; i < virtualRegs.size(); ++i) {
    auto &options_row = options[i];
    if (std::all_of(options_row.begin(), options_row.end(),
                    [](int x) { return x == 0; })) {
      mustSpill.push_back(i);
    }
  }

  SmallVector<Register, 4> SplitVRegs;
  for(unsigned int i : mustSpill) {
    LLVM_DEBUG(dbgs() << "Spilling VR " << virtualRegs[i] << "\n");
    auto vr = Register::index2VirtReg(virtualRegs[i]);
    LiveRangeEdit LRE(&LIS->getInterval(vr), SplitVRegs, *MF, *LIS, VRM, this, &DeadRemats);
    spiller().spill(LRE);
    return true;
  }

  return !mustSpill.empty();
}

ACOColoringResult
RAAco::doACOColoring(Graph &graph, ColorOptions &colorOptions, 
    RAAco::ColorMappings &colorMappings, const std::vector<unsigned int> &virtualRegs) {
  
  Parameters params(graph.size(), colorOptions[0].size());
  params.allowedColors = colorOptions;

  for(auto virtualReg : virtualRegs) {
    params.spillCosts.push_back(
      LIS->getInterval(Register::index2VirtReg(virtualReg)).weight()
    );
  }

  params.alpha = Alpha;
  params.beta = Beta;
  params.rho = Rho;
  params.maxTime = MaxTime;
  params.maxTabucolTime = MaxTabucolTime;
  params.maxCycles = MaxCycles;
  params.maxTabulcolCycles = MaxTabucolCycles;
  params.numAnts = NumAnts;
  params.gap = Gap;
  params.spillCostImportance = SpillCostImportance;

  Solution solution(graph.size());
  LLVM_DEBUG(dbgs() << "Adjacency matrix size: " << graph.size() << "x"
         << (!graph.empty() ? graph[0].size() : 0) << "\n");
  LLVM_DEBUG(dbgs() << "STARTING ACO COLORING\n");
  auto start = std::chrono::high_resolution_clock::now();
  ColorAnt3WithSpilling(solution, graph, params);
  auto end = std::chrono::high_resolution_clock::now();
  auto elapsed =
      std::chrono::duration_cast<std::chrono::milliseconds>(end - start);
  LLVM_DEBUG(dbgs() << "FINISHED ACO COLORING. ELAPSED: " << elapsed.count() << " ms\n");

  auto &colors = solution.vertexColors;

  ACOColoringResult coloring{};

  LLVM_DEBUG(dbgs() << "**** ACO COLORING ****\n");

  // convert output of ACO to useful format for actual allocation
  for (unsigned int i = 0; i < colors.size(); ++i) {
    Register r{Register::index2VirtReg(virtualRegs[i])};

    LiveInterval *virtReg{&LIS->getInterval(r)};
    const TargetRegisterClass *rc = MRI->getRegClass(virtReg->reg());

    std::optional<MCPhysReg> physReg{std::nullopt};
    if (colors[i] >= 0) {
      // negative color will indicate a spill
      physReg = MCRegister{
          static_cast<MCPhysReg>(getPhyRegFromColor(colorMappings, colors[i], rc))};
    }

    coloring[virtReg] = physReg;
    const char *name;
    if (physReg.has_value()) {
      name = TRI->getName(*physReg);
    } else {
      name = "spilled!";
    }

    LLVM_DEBUG(dbgs() << "VR " << i << " (real idx " << virtualRegs[i]
                      << ") = " << colors[i] << " (" << name << ")\n");
  }

  return coloring;
}

bool RAAco::allocateACOColors(const ACOColoringResult &coloring) {
  bool spilled{false};
  SmallVector<Register, 4> SplitVRegs;

  for (const auto &[virtReg, physReg] : coloring) {
    if (!physReg.has_value()) {
      LLVM_DEBUG(dbgs() << "Spilling VR " << Register::virtReg2Index(virtReg->reg())
             << "\n");
      spilled = true;
      LiveRangeEdit LRE(virtReg, SplitVRegs, *MF, *LIS, VRM, this, &DeadRemats);
      spiller().spill(LRE);
    }
  }

  if (spilled) {
    return true;
  }

  for (const auto &[virtReg, physReg] : coloring) {
    if (physReg.has_value()) {
      if (auto res = Matrix->checkInterference(*virtReg, *physReg);
          res != LiveRegMatrix::InterferenceKind::IK_Free) {
        LLVM_DEBUG(dbgs() << "VR " << Register::virtReg2Index(virtReg->reg())
               << " conflicted with assigned reg " << TRI->getName(*physReg)
               << " Conflict Type: " << res << "\n");
        llvm_unreachable(
            "Tried to assign a register with unresolved interference");
      }
      Matrix->assign(*virtReg, *physReg);
      LLVM_DEBUG(dbgs() << "Assigned real idx VR "
                        << Register::virtReg2Index(virtReg->reg()) << " to "
                        << TRI->getName(*physReg) << "\n");
    } else {
      LLVM_DEBUG(dbgs() << "Somehow missed a spill\n");
    }
  }

  return false;
}

bool RAAco::runOnMachineFunction(MachineFunction &mf) {
  LLVM_DEBUG(dbgs() << "********** ACO REGISTER ALLOCATION **********\n"
         << "********** Function: " << mf.getName() << '\n');

  LLVM_DEBUG(dbgs() << "Alpha = " << Alpha << "\n");
  LLVM_DEBUG(dbgs() << "Beta = " << Beta << "\n");
  LLVM_DEBUG(dbgs() << "Rho = " << Rho << "\n");
  LLVM_DEBUG(dbgs() << "MaxTime = " << MaxTime << "\n");
  LLVM_DEBUG(dbgs() << "MaxTabucolTime = " << MaxTabucolTime << "\n");
  LLVM_DEBUG(dbgs() << "MaxCycles = " << MaxCycles << "\n");
  LLVM_DEBUG(dbgs() << "MaxTabucolCycles = " << MaxTabucolCycles << "\n");
  LLVM_DEBUG(dbgs() << "NumAnts = " << NumAnts << "\n");
  LLVM_DEBUG(dbgs() << "Gap = " << Gap << "\n");
  LLVM_DEBUG(dbgs() << "SpillCostImportance = " << SpillCostImportance << "\n");

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
  bool spillsOccurred{true};

  do {
    std::vector<unsigned int> virtualRegs = makeVirtualRegsList();
    if(virtualRegs.empty()) {
      break;
    }

    RAAco::ColorMappings colorMappings = createColorMappings(virtualRegs);
    ColorOptions options = makeColorOptions(virtualRegs, colorMappings);

    LLVM_DEBUG(dbgs() << "** COLOR OPTIONS MATRIX **\n");
    for (auto &row : options) {
      for (bool el : row) {
        LLVM_DEBUG(dbgs() << el << " ");
      }
      LLVM_DEBUG(dbgs() << "\n");
    }

    if(handleForcedSpills(options, virtualRegs)) {
      Matrix->invalidateVirtRegs();
      spillsOccurred = true;
      continue;
    }
    
    Graph graph = makeGraph(virtualRegs);

    printGraph(graph);

    ACOColoringResult coloring = doACOColoring(graph, options, colorMappings, virtualRegs);
    spillsOccurred = allocateACOColors(coloring);
    Matrix->invalidateVirtRegs();
  } while (spillsOccurred);

  postOptimization();

  // Diagnostic output before rewriting
  LLVM_DEBUG(dbgs() << "Post alloc VirtRegMap:\n" << *VRM << "\n");

  releaseMemory();
  return true;
}

FunctionPass *llvm::createAcoRegisterAllocator() { return new RAAco(); }

FunctionPass *llvm::createAcoRegisterAllocator(RegAllocFilterFunc F) {
  return new RAAco(F);
}
