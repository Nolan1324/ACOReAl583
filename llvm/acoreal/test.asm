	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	stp	x28, x27, [sp, #32]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	.cfi_offset w27, -8
	.cfi_offset w28, -16
	mov	x0, x1
	stp	w0, wzr, [sp, #24]
	str	x1, [sp, #16]
	ldr	x28, [x1, #8]
	ldrsb	w9, [x28, #1]
	ldrsb	w10, [x28, #2]
	add	w11, w9, w10
	add	w12, w10, w11
	str	w11, [sp, #12]
	stp	w10, w12, [sp, #4]
	ldp	x28, x27, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
