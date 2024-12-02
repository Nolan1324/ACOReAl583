	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	_streaming_compatible_with_predicate_vectors ; -- Begin function streaming_compatible_with_predicate_vectors
	.p2align	2
	.variant_pcs	_streaming_compatible_with_predicate_vectors
_streaming_compatible_with_predicate_vectors: ; @streaming_compatible_with_predicate_vectors
; %bb.0:
	str	x28, [sp, #-32]!                ; 8-byte Folded Spill
	cntd	x9
	stp	x19, x30, [sp, #8]              ; 16-byte Folded Spill
	str	x9, [sp, #24]                   ; 8-byte Folded Spill
	addvl	sp, sp, #-18
	str	p15, [sp, #4, mul vl]           ; 2-byte Folded Spill
	str	p14, [sp, #5, mul vl]           ; 2-byte Folded Spill
	str	p13, [sp, #6, mul vl]           ; 2-byte Folded Spill
	str	p12, [sp, #7, mul vl]           ; 2-byte Folded Spill
	str	p11, [sp, #8, mul vl]           ; 2-byte Folded Spill
	str	p10, [sp, #9, mul vl]           ; 2-byte Folded Spill
	str	p9, [sp, #10, mul vl]           ; 2-byte Folded Spill
	str	p8, [sp, #11, mul vl]           ; 2-byte Folded Spill
	str	p7, [sp, #12, mul vl]           ; 2-byte Folded Spill
	str	p6, [sp, #13, mul vl]           ; 2-byte Folded Spill
	str	p5, [sp, #14, mul vl]           ; 2-byte Folded Spill
	str	p4, [sp, #15, mul vl]           ; 2-byte Folded Spill
	str	z23, [sp, #2, mul vl]           ; 16-byte Folded Spill
	str	z22, [sp, #3, mul vl]           ; 16-byte Folded Spill
	str	z21, [sp, #4, mul vl]           ; 16-byte Folded Spill
	str	z20, [sp, #5, mul vl]           ; 16-byte Folded Spill
	str	z19, [sp, #6, mul vl]           ; 16-byte Folded Spill
	str	z18, [sp, #7, mul vl]           ; 16-byte Folded Spill
	str	z17, [sp, #8, mul vl]           ; 16-byte Folded Spill
	str	z16, [sp, #9, mul vl]           ; 16-byte Folded Spill
	str	z15, [sp, #10, mul vl]          ; 16-byte Folded Spill
	str	z14, [sp, #11, mul vl]          ; 16-byte Folded Spill
	str	z13, [sp, #12, mul vl]          ; 16-byte Folded Spill
	str	z12, [sp, #13, mul vl]          ; 16-byte Folded Spill
	str	z11, [sp, #14, mul vl]          ; 16-byte Folded Spill
	str	z10, [sp, #15, mul vl]          ; 16-byte Folded Spill
	str	z9, [sp, #16, mul vl]           ; 16-byte Folded Spill
	str	z8, [sp, #17, mul vl]           ; 16-byte Folded Spill
	addvl	sp, sp, #-1
	str	p0, [sp, #7, mul vl]            ; 2-byte Folded Spill
	bl	___arm_sme_state
	and	x19, x0, #0x1
	tbz	w19, #0, LBB0_2
; %bb.1:
	smstop	sm
LBB0_2:
	ldr	p0, [sp, #7, mul vl]            ; 2-byte Folded Reload
	bl	_normal_callee_predicate_vec_arg
	str	p0, [sp, #6, mul vl]            ; 2-byte Folded Spill
	tbz	w19, #0, LBB0_4
; %bb.3:
	smstart	sm
LBB0_4:
	ldr	p0, [sp, #7, mul vl]            ; 2-byte Folded Reload
	ldr	p1, [sp, #6, mul vl]            ; 2-byte Folded Reload
	and	p0.b, p1/z, p1.b, p0.b
	addvl	sp, sp, #1
	ldr	z23, [sp, #2, mul vl]           ; 16-byte Folded Reload
	ldr	z22, [sp, #3, mul vl]           ; 16-byte Folded Reload
	ldr	z21, [sp, #4, mul vl]           ; 16-byte Folded Reload
	ldr	z20, [sp, #5, mul vl]           ; 16-byte Folded Reload
	ldr	z19, [sp, #6, mul vl]           ; 16-byte Folded Reload
	ldr	z18, [sp, #7, mul vl]           ; 16-byte Folded Reload
	ldr	z17, [sp, #8, mul vl]           ; 16-byte Folded Reload
	ldr	z16, [sp, #9, mul vl]           ; 16-byte Folded Reload
	ldr	z15, [sp, #10, mul vl]          ; 16-byte Folded Reload
	ldr	z14, [sp, #11, mul vl]          ; 16-byte Folded Reload
	ldr	z13, [sp, #12, mul vl]          ; 16-byte Folded Reload
	ldr	z12, [sp, #13, mul vl]          ; 16-byte Folded Reload
	ldr	z11, [sp, #14, mul vl]          ; 16-byte Folded Reload
	ldr	z10, [sp, #15, mul vl]          ; 16-byte Folded Reload
	ldr	z9, [sp, #16, mul vl]           ; 16-byte Folded Reload
	ldr	z8, [sp, #17, mul vl]           ; 16-byte Folded Reload
	ldr	p15, [sp, #4, mul vl]           ; 2-byte Folded Reload
	ldr	p14, [sp, #5, mul vl]           ; 2-byte Folded Reload
	ldr	p13, [sp, #6, mul vl]           ; 2-byte Folded Reload
	ldr	p12, [sp, #7, mul vl]           ; 2-byte Folded Reload
	ldr	p11, [sp, #8, mul vl]           ; 2-byte Folded Reload
	ldr	p10, [sp, #9, mul vl]           ; 2-byte Folded Reload
	ldr	p9, [sp, #10, mul vl]           ; 2-byte Folded Reload
	ldr	p8, [sp, #11, mul vl]           ; 2-byte Folded Reload
	ldr	p7, [sp, #12, mul vl]           ; 2-byte Folded Reload
	ldr	p6, [sp, #13, mul vl]           ; 2-byte Folded Reload
	ldr	p5, [sp, #14, mul vl]           ; 2-byte Folded Reload
	ldr	p4, [sp, #15, mul vl]           ; 2-byte Folded Reload
	addvl	sp, sp, #18
	ldp	x19, x30, [sp, #8]              ; 16-byte Folded Reload
	ldr	x28, [sp], #32                  ; 8-byte Folded Reload
	ret
                                        ; -- End function
.subsections_via_symbols
