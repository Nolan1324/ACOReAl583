	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	.cfi_def_cfa_offset 32
	stp	w0, wzr, [sp, #24]
	str	x1, [sp, #16]
	ldr	x8, [x1, #8]
	ldrsb	w9, [x8, #1]
	ldrsb	w8, [x8, #2]
	add	w9, w9, w8
	add	w0, w8, w9
	str	w9, [sp, #12]
	stp	w8, w0, [sp, #4]
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
