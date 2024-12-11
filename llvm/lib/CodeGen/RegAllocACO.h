//===-- RegAllocAco.h - Aco Register Allocator ----------------------===//
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

#ifndef LLVM_CODEGEN_REGALLOCACO_H_
#define LLVM_CODEGEN_REGALLOCACO_H_

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

#include "ACOGraphColoring.h"

using ACOColoringResult = std::map<llvm::LiveInterval *, std::optional<llvm::MCRegister>>;
using Graph = std::vector<std::vector<bool>>;
using ColorOptions = std::vector<std::vector<bool>>;

namespace llvm {

struct CompSpillWeight {
  bool operator()(const LiveInterval *A, const LiveInterval *B) const {
    return A->weight() < B->weight();
  }
};

class LLVM_LIBRARY_VISIBILITY RAAco : public MachineFunctionPass,
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

  struct ColorMappings {
    std::unordered_map<int, std::unordered_set<MCPhysReg>> colorsToRegs{};
    std::unordered_map<MCPhysReg, int> regsToColors{};
  };


  bool LRE_CanEraseVirtReg(Register) override;
  void LRE_WillShrinkVirtReg(Register) override;

   /* ACO */
  std::vector<unsigned int> makeVirtualRegsList();
  Graph makeGraph(const std::vector<unsigned int> &virtualRegs);
  int getNumberOfColors(const ColorMappings &mappings);
  ColorOptions makeColorOptions(const std::vector<unsigned int> &virtualRegs, const ColorMappings &mappings);
  ACOColoringResult doACOColoring(Graph &graph, ColorOptions &colorOptions, 
    RAAco::ColorMappings &colorMappings, const std::vector<unsigned int> &virtualRegs);
  // Returns true if a register was spilled, false otherwise
  bool allocateACOColors(const ACOColoringResult &coloring);
  MCPhysReg getColorFromPhyReg(const ColorMappings &mappings, MCPhysReg physReg);
  ColorMappings createColorMappings(const std::vector<unsigned int> &virtualRegs);
  MCPhysReg getPhyRegFromColor(const ColorMappings &mappings, int color, const TargetRegisterClass *rc);
  bool handleForcedSpills(ColorOptions &options, const std::vector<unsigned int> &virtualRegs);

public:
  RAAco(const RegAllocFilterFunc F = nullptr);

  /// Return the pass name.
  StringRef getPassName() const override { return "Aco Register Allocator"; }

  /// RAAco analysis usage.
  void getAnalysisUsage(AnalysisUsage &AU) const override;

  void releaseMemory() override;

  Spiller &spiller() override { return *SpillerInstance; }

  void enqueueImpl(const LiveInterval *LI) override { llvm_unreachable("not implemented"); }

  const LiveInterval *dequeue() override { llvm_unreachable("not implemented"); }

  MCRegister selectOrSplit(const LiveInterval &VirtReg,
                           SmallVectorImpl<Register> &SplitVRegs) override { llvm_unreachable("not implemented"); }

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

  bool spillInterferences(const LiveInterval &VirtReg, MCRegister PhysReg,
                          SmallVectorImpl<Register> &SplitVRegs) { llvm_unreachable("not implemented"); }

  static char ID;
};

} // namespace llvm

#endif // LLVM_CODEGEN_REGALLOCACO_H_