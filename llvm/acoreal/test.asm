	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	stp	x22, x21, [sp, #32]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	.cfi_offset w21, -8
	.cfi_offset w22, -16
	stp	w0, wzr, [sp, #24]
	str	x1, [sp, #16]
	ldr	x22, [x1, #8]
	ldrsb	w9, [x22, #1]
	ldrsb	w7, [x22, #2]
	add	w11, w9, w7
	add	w0, w7, w11
	str	w11, [sp, #12]
	stp	w7, w0, [sp, #4]
	ldp	x22, x21, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
