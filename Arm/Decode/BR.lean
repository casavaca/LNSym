/-
Copyright (c) 2023 Amazon.com, Inc. or its affiliates. All Rights Reserved.
Author(s): Shilpi Goel
-/
import Arm.BitVec

------------------------------------------------------------------------------

section Decode

open Std.BitVec

-- Branches, Exception Generating and System Instructions

structure Compare_branch_inst where
  sf     : BitVec 1               -- [31:31]
  _fixed : BitVec 5 := 0b011010#5 -- [30:25]
  op     : BitVec 1               -- [24:24]
  imm19  : BitVec 19              -- [23:5]
  Rt     : BitVec 5               --  [4:0]
deriving DecidableEq, Repr

instance : ToString Compare_branch_inst where toString a := toString (repr a)

structure Uncond_branch_imm_inst where
  op     : BitVec 1              -- [31:31]
  _fixed : BitVec 5 := 0b00101#5 -- [30:26]
  imm26  : BitVec 26             --  [25:0]
deriving DecidableEq, Repr

instance : ToString Uncond_branch_imm_inst where toString a := toString (repr a)

structure Uncond_branch_reg_inst where
  _fixed : BitVec 7 := 0b1101011#7 -- [31:25]
  opc    : BitVec 4                -- [24:21]
  op2    : BitVec 5                -- [20:16]
  op3    : BitVec 6                -- [15:10]
  Rn     : BitVec 5                --   [9:5]
  -- This field is indeed called
  -- op4 in the Arm manual; note
  -- that the width is 5 bits.
  op4    : BitVec 5                --  [4:0]
deriving DecidableEq, Repr

instance : ToString Uncond_branch_reg_inst where toString a := toString (repr a)

inductive BranchInst where
  | Compare_branch :
    Compare_branch_inst → BranchInst
  | Uncond_branch_imm :
    Uncond_branch_imm_inst → BranchInst
  | Uncond_branch_reg :
    Uncond_branch_reg_inst → BranchInst
deriving DecidableEq, Repr

instance : ToString BranchInst where toString a := toString (repr a)

end Decode