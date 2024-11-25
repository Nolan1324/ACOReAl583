	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	mov	w8, #30                         ; =0x1e
	mov	w9, #35                         ; =0x23
	str	w9, [sp, #12]
	mov	w10, #65                        ; =0x41
	stp	w8, w10, [sp, #4]
	mov	w0, #0                          ; =0x0
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
