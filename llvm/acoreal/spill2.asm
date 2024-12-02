	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 13, 0
	.globl	_main                           ; -- Begin function main
	.p2align	2
_main:                                  ; @main
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #480
	stp	x28, x27, [sp, #416]            ; 16-byte Folded Spill
	stp	x26, x25, [sp, #432]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #448]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #464]            ; 16-byte Folded Spill
	add	x29, sp, #464
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w25, -40
	.cfi_offset w26, -48
	.cfi_offset w27, -56
	.cfi_offset w28, -64
	stur	wzr, [x29, #-52]
Lloh0:
	adrp	x26, __ZNSt3__14coutE@GOTPAGE
Lloh1:
	ldr	x26, [x26, __ZNSt3__14coutE@GOTPAGEOFF]
Lloh2:
	adrp	x1, l_.str@PAGE
Lloh3:
	add	x1, x1, l_.str@PAGEOFF
	mov	x0, x26
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
Lloh4:
	adrp	x0, __ZNSt3__13cinE@GOTPAGE
Lloh5:
	ldr	x0, [x0, __ZNSt3__13cinE@GOTPAGEOFF]
	sub	x1, x29, #56
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #60
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #64
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #68
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #72
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #76
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #80
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #84
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #88
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #92
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #96
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #100
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #104
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #108
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #112
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #116
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #120
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #124
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #128
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #132
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #136
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #140
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #144
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #148
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #152
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #156
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #160
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #164
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #168
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #172
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #176
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #180
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #184
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #188
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #192
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #196
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #200
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #204
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #208
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #212
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #216
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #220
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #224
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	sub	x1, x29, #228
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #232
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #228
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #224
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #220
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #216
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #212
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #208
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #204
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #200
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #196
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #192
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #188
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #184
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #180
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #176
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #172
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #168
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #164
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #160
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #156
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #152
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #148
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #144
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #140
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #136
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #132
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #128
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #124
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #120
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #116
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #112
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #108
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #104
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #100
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #96
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #92
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #88
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #84
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #80
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #76
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #72
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #68
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #64
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #60
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #56
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #52
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #48
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #44
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #40
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #36
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #32
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #28
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #24
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #20
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #16
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
	add	x1, sp, #12
	bl	__ZNSt3__113basic_istreamIcNS_11char_traitsIcEEErsERi
Lloh6:
	adrp	x1, l_.str.1@PAGE
Lloh7:
	add	x1, x1, l_.str.1@PAGEOFF
	mov	x0, x26
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-56]
	mov	x0, x26
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
Lloh8:
	adrp	x25, l_.str.2@PAGE
Lloh9:
	add	x25, x25, l_.str.2@PAGEOFF
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-60]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-64]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-68]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-72]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-76]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-80]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-84]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-88]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-92]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
Lloh10:
	adrp	x20, l_.str.3@PAGE
Lloh11:
	add	x20, x20, l_.str.3@PAGEOFF
	mov	x1, x20
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-96]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-100]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-104]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-108]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-112]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-116]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-120]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-124]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-128]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-132]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x20
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-136]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-140]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-144]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-148]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-152]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-156]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-160]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-164]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-168]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-172]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x20
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-176]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-180]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-184]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-188]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-192]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-196]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-200]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-204]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-208]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-212]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x20
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-216]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-220]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-224]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldur	w1, [x29, #-228]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #232]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #228]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #224]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #220]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #216]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #212]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x20
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #208]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #204]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #200]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #196]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #192]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #188]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #184]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #180]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #176]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #172]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x20
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #168]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #164]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #160]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #156]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #152]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #148]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #144]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #140]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #136]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #132]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x20
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #128]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #124]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #120]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #116]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #112]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #108]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #104]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #100]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #96]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #92]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x20
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #88]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #84]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #80]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #76]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #72]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #68]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #64]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #60]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #56]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #52]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x20
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #48]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #44]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #40]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #36]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #32]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #28]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #24]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #20]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #16]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x25
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	ldr	w1, [sp, #12]
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEElsEi
	mov	x1, x20
	bl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	mov	w0, #0                          ; =0x0
	ldp	x29, x30, [sp, #464]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #448]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #432]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #416]            ; 16-byte Folded Reload
	add	sp, sp, #480
	ret
	.loh AdrpAdd	Lloh10, Lloh11
	.loh AdrpAdd	Lloh8, Lloh9
	.loh AdrpAdd	Lloh6, Lloh7
	.loh AdrpLdrGot	Lloh4, Lloh5
	.loh AdrpAdd	Lloh2, Lloh3
	.loh AdrpLdrGot	Lloh0, Lloh1
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc ; -- Begin function _ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	.globl	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	.weak_definition	__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	.p2align	2
__ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc: ; @_ZNSt3__1lsB8ne180100INS_11char_traitsIcEEEERNS_13basic_ostreamIcT_EES6_PKc
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x21, x1
	mov	x19, x0
	stp	x1, x0, [sp]
	mov	x0, x1
	bl	__ZNSt3__111char_traitsIcE6lengthB8ne180100EPKc
	mov	x7, x0
	mov	x0, x19
	mov	x1, x21
	mov	x2, x7
	bl	__ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m ; -- Begin function _ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.globl	__ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.weak_definition	__ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
	.p2align	2
__ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m: ; @_ZNSt3__124__put_character_sequenceB8ne180100IcNS_11char_traitsIcEEEERNS_13basic_ostreamIT_T0_EES7_PKS4_m
Lfunc_begin0:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception0
; %bb.0:
	sub	sp, sp, #160
	stp	x28, x27, [sp, #80]             ; 16-byte Folded Spill
	stp	x24, x23, [sp, #96]             ; 16-byte Folded Spill
	stp	x22, x21, [sp, #112]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #128]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #144]            ; 16-byte Folded Spill
	add	x29, sp, #144
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w23, -56
	.cfi_offset w24, -64
	.cfi_offset w27, -72
	.cfi_offset w28, -80
	mov	x23, x2
	mov	x2, x0
	stp	x1, x0, [sp, #64]
	str	x23, [sp, #56]
Ltmp0:
	add	x0, sp, #40
	mov	x1, x2
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryC1ERS3_
Ltmp1:
; %bb.1:
	add	x0, sp, #40
	bl	__ZNKSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentrycvbB8ne180100Ev
	cbz	w0, LBB2_6
; %bb.2:
	ldr	x1, [sp, #72]
	add	x0, sp, #8
	bl	__ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC1B8ne180100ERNS_13basic_ostreamIcS2_EE
	ldp	x19, x0, [sp, #64]
	ldr	x4, [x0]
	ldur	x22, [x4, #-24]
	add	x0, x0, x22
	bl	__ZNKSt3__18ios_base5flagsB8ne180100Ev
	mov	w24, #176                       ; =0xb0
	and	w13, w0, w24
	ldp	x5, x14, [sp, #56]
	add	x24, x14, x5
	cmp	w13, #32
	csel	x28, x24, x14, eq
	ldr	x27, [sp, #72]
	ldr	x12, [x27]
	ldur	x20, [x12, #-24]
Ltmp3:
	add	x0, x27, x20
	bl	__ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillB8ne180100Ev
Ltmp4:
; %bb.3:
	mov	x12, x0
	ldr	x0, [sp, #8]
Ltmp5:
	add	x4, x27, x20
	mov	x1, x19
	mov	x2, x28
	mov	x3, x24
	mov	x5, x12
	bl	__ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
Ltmp6:
; %bb.4:
	str	x0, [sp, #16]
	add	x0, sp, #16
	bl	__ZNKSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEE6failedB8ne180100Ev
	cbz	w0, LBB2_6
; %bb.5:
	ldr	x10, [sp, #72]
	ldr	x0, [x10]
	ldur	x3, [x0, #-24]
Ltmp7:
	add	x0, x10, x3
	mov	w1, #5                          ; =0x5
	bl	__ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateB8ne180100Ej
Ltmp8:
LBB2_6:
	add	x0, sp, #40
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev
LBB2_7:
	ldr	x0, [sp, #72]
	ldp	x29, x30, [sp, #144]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #128]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #112]            ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #96]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #80]             ; 16-byte Folded Reload
	add	sp, sp, #160
	ret
LBB2_8:
Ltmp2:
	mov	x5, x1
	str	x0, [sp, #32]
	str	w5, [sp, #28]
	b	LBB2_10
LBB2_9:
Ltmp9:
	mov	x7, x1
	str	x0, [sp, #32]
	str	w7, [sp, #28]
	add	x0, sp, #40
	bl	__ZNSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentryD1Ev
LBB2_10:
	ldr	x0, [sp, #32]
	bl	___cxa_begin_catch
	ldr	x30, [sp, #72]
	ldr	x20, [x30]
	ldur	x17, [x20, #-24]
Ltmp10:
	add	x0, x30, x17
	bl	__ZNSt3__18ios_base33__set_badbit_and_consider_rethrowEv
Ltmp11:
; %bb.11:
	bl	___cxa_end_catch
	b	LBB2_7
LBB2_12:
Ltmp12:
	mov	x7, x1
	str	x0, [sp, #32]
	str	w7, [sp, #28]
Ltmp13:
	bl	___cxa_end_catch
Ltmp14:
; %bb.13:
	ldr	x0, [sp, #32]
	bl	__Unwind_Resume
LBB2_14:
Ltmp15:
	bl	___clang_call_terminate
Lfunc_end0:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table2:
Lexception0:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	155                             ; @TType Encoding = indirect pcrel sdata4
	.uleb128 Lttbase0-Lttbaseref0
Lttbaseref0:
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end0-Lcst_begin0
Lcst_begin0:
	.uleb128 Ltmp0-Lfunc_begin0             ; >> Call Site 1 <<
	.uleb128 Ltmp1-Ltmp0                    ;   Call between Ltmp0 and Ltmp1
	.uleb128 Ltmp2-Lfunc_begin0             ;     jumps to Ltmp2
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp3-Lfunc_begin0             ; >> Call Site 2 <<
	.uleb128 Ltmp8-Ltmp3                    ;   Call between Ltmp3 and Ltmp8
	.uleb128 Ltmp9-Lfunc_begin0             ;     jumps to Ltmp9
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp8-Lfunc_begin0             ; >> Call Site 3 <<
	.uleb128 Ltmp10-Ltmp8                   ;   Call between Ltmp8 and Ltmp10
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp10-Lfunc_begin0            ; >> Call Site 4 <<
	.uleb128 Ltmp11-Ltmp10                  ;   Call between Ltmp10 and Ltmp11
	.uleb128 Ltmp12-Lfunc_begin0            ;     jumps to Ltmp12
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp11-Lfunc_begin0            ; >> Call Site 5 <<
	.uleb128 Ltmp13-Ltmp11                  ;   Call between Ltmp11 and Ltmp13
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp13-Lfunc_begin0            ; >> Call Site 6 <<
	.uleb128 Ltmp14-Ltmp13                  ;   Call between Ltmp13 and Ltmp14
	.uleb128 Ltmp15-Lfunc_begin0            ;     jumps to Ltmp15
	.byte	1                               ;   On action: 1
	.uleb128 Ltmp14-Lfunc_begin0            ; >> Call Site 7 <<
	.uleb128 Lfunc_end0-Ltmp14              ;   Call between Ltmp14 and Lfunc_end0
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end0:
	.byte	1                               ; >> Action Record 1 <<
                                        ;   Catch TypeInfo 1
	.byte	0                               ;   No further actions
	.p2align	2, 0x0
                                        ; >> Catch TypeInfos <<
	.long	0                               ; TypeInfo 1
Lttbase0:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt3__111char_traitsIcE6lengthB8ne180100EPKc ; -- Begin function _ZNSt3__111char_traitsIcE6lengthB8ne180100EPKc
	.globl	__ZNSt3__111char_traitsIcE6lengthB8ne180100EPKc
	.weak_definition	__ZNSt3__111char_traitsIcE6lengthB8ne180100EPKc
	.p2align	2
__ZNSt3__111char_traitsIcE6lengthB8ne180100EPKc: ; @_ZNSt3__111char_traitsIcE6lengthB8ne180100EPKc
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	bl	__ZNSt3__118__constexpr_strlenB8ne180100EPKc
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNKSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentrycvbB8ne180100Ev ; -- Begin function _ZNKSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentrycvbB8ne180100Ev
	.globl	__ZNKSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentrycvbB8ne180100Ev
	.weak_definition	__ZNKSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentrycvbB8ne180100Ev
	.p2align	2
__ZNKSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentrycvbB8ne180100Ev: ; @_ZNKSt3__113basic_ostreamIcNS_11char_traitsIcEEE6sentrycvbB8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x28, x27, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w27, -8
	.cfi_offset w28, -16
	str	x0, [sp, #8]
	ldrb	w28, [x0]
	and	w0, w28, #0x1
	ldp	x28, x27, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_ ; -- Begin function _ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.globl	__ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.weak_definition	__ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
	.p2align	2
__ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_: ; @_ZNSt3__116__pad_and_outputB8ne180100IcNS_11char_traitsIcEEEENS_19ostreambuf_iteratorIT_T0_EES6_PKS4_S8_S8_RNS_8ios_baseES4_
Lfunc_begin1:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception1
; %bb.0:
	sub	sp, sp, #208
	stp	x28, x27, [sp, #128]            ; 16-byte Folded Spill
	stp	x26, x25, [sp, #144]            ; 16-byte Folded Spill
	stp	x22, x21, [sp, #160]            ; 16-byte Folded Spill
	stp	x20, x19, [sp, #176]            ; 16-byte Folded Spill
	stp	x29, x30, [sp, #192]            ; 16-byte Folded Spill
	add	x29, sp, #192
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	.cfi_offset w25, -56
	.cfi_offset w26, -64
	.cfi_offset w27, -72
	.cfi_offset w28, -80
	stp	x1, x0, [x29, #-88]
	stp	x3, x2, [sp, #88]
	str	x4, [sp, #80]
	strb	w5, [sp, #79]
	cbz	x0, LBB5_13
; %bb.1:
	ldp	x0, x19, [sp, #80]
	ldur	x8, [x29, #-88]
	sub	x25, x19, x8
	str	x25, [sp, #64]
	bl	__ZNKSt3__18ios_base5widthB8ne180100Ev
	ldr	x28, [sp, #64]
	subs	x21, x0, x28
	csel	x14, x21, xzr, gt
	ldr	x4, [sp, #96]
	ldur	x25, [x29, #-88]
	sub	x15, x4, x25
	stp	x15, x14, [sp, #48]
	cmp	x15, #1
	b.lt	LBB5_3
; %bb.2:
	ldp	x1, x0, [x29, #-88]
	ldr	x2, [sp, #48]
	bl	__ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnB8ne180100EPKcl
	ldr	x12, [sp, #48]
	cmp	x0, x12
	b.ne	LBB5_11
LBB5_3:
	ldr	x3, [sp, #56]
	cmp	x3, #1
	b.lt	LBB5_9
; %bb.4:
	ldr	x1, [sp, #56]
	ldrsb	w2, [sp, #79]
	add	x0, sp, #24
	bl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B8ne180100Emc
	ldur	x21, [x29, #-80]
	add	x0, sp, #24
	bl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataB8ne180100Ev
	mov	x8, x0
	ldr	x2, [sp, #56]
Ltmp16:
	mov	x0, x21
	mov	x1, x8
	bl	__ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnB8ne180100EPKcl
Ltmp17:
; %bb.5:
	ldr	x25, [sp, #56]
	cmp	x0, x25
	b.eq	LBB5_7
; %bb.6:
	stp	xzr, xzr, [x29, #-80]
	mov	w10, #1                         ; =0x1
	b	LBB5_8
LBB5_7:
	mov	w10, #0                         ; =0x0
LBB5_8:
	str	w10, [sp, #8]
	add	x0, sp, #24
	bl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev
	ldr	w14, [sp, #8]
	cbnz	w14, LBB5_14
LBB5_9:
	ldp	x14, x9, [sp, #88]
	sub	x26, x14, x9
	str	x26, [sp, #48]
	cmp	x26, #1
	b.lt	LBB5_12
; %bb.10:
	ldur	x0, [x29, #-80]
	ldr	x1, [sp, #96]
	ldr	x2, [sp, #48]
	bl	__ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnB8ne180100EPKcl
	ldr	x26, [sp, #48]
	cmp	x0, x26
	b.eq	LBB5_12
LBB5_11:
	stur	xzr, [x29, #-80]
	b	LBB5_13
LBB5_12:
	ldr	x0, [sp, #80]
	mov	x1, #0                          ; =0x0
	bl	__ZNSt3__18ios_base5widthB8ne180100El
LBB5_13:                                ; %.sink.split
	ldur	x15, [x29, #-80]
	stur	x15, [x29, #-72]
LBB5_14:
	ldur	x0, [x29, #-72]
	ldp	x29, x30, [sp, #192]            ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #176]            ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #160]            ; 16-byte Folded Reload
	ldp	x26, x25, [sp, #144]            ; 16-byte Folded Reload
	ldp	x28, x27, [sp, #128]            ; 16-byte Folded Reload
	add	sp, sp, #208
	ret
LBB5_15:
Ltmp18:
	mov	x16, x1
	str	x0, [sp, #16]
	str	w16, [sp, #12]
	add	x0, sp, #24
	bl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEED1Ev
	ldr	x0, [sp, #16]
	bl	__Unwind_Resume
Lfunc_end1:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table5:
Lexception1:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end1-Lcst_begin1
Lcst_begin1:
	.uleb128 Lfunc_begin1-Lfunc_begin1      ; >> Call Site 1 <<
	.uleb128 Ltmp16-Lfunc_begin1            ;   Call between Lfunc_begin1 and Ltmp16
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp16-Lfunc_begin1            ; >> Call Site 2 <<
	.uleb128 Ltmp17-Ltmp16                  ;   Call between Ltmp16 and Ltmp17
	.uleb128 Ltmp18-Lfunc_begin1            ;     jumps to Ltmp18
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp17-Lfunc_begin1            ; >> Call Site 3 <<
	.uleb128 Lfunc_end1-Ltmp17              ;   Call between Ltmp17 and Lfunc_end1
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end1:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC1B8ne180100ERNS_13basic_ostreamIcS2_EE ; -- Begin function _ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC1B8ne180100ERNS_13basic_ostreamIcS2_EE
	.globl	__ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC1B8ne180100ERNS_13basic_ostreamIcS2_EE
	.weak_def_can_be_hidden	__ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC1B8ne180100ERNS_13basic_ostreamIcS2_EE
	.p2align	2
__ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC1B8ne180100ERNS_13basic_ostreamIcS2_EE: ; @_ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC1B8ne180100ERNS_13basic_ostreamIcS2_EE
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stp	x1, x0, [sp]
	bl	__ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC2B8ne180100ERNS_13basic_ostreamIcS2_EE
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNKSt3__18ios_base5flagsB8ne180100Ev ; -- Begin function _ZNKSt3__18ios_base5flagsB8ne180100Ev
	.globl	__ZNKSt3__18ios_base5flagsB8ne180100Ev
	.weak_definition	__ZNKSt3__18ios_base5flagsB8ne180100Ev
	.p2align	2
__ZNKSt3__18ios_base5flagsB8ne180100Ev: ; @_ZNKSt3__18ios_base5flagsB8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	ldr	w0, [x0, #8]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillB8ne180100Ev ; -- Begin function _ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillB8ne180100Ev
	.globl	__ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillB8ne180100Ev
	.weak_definition	__ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillB8ne180100Ev
	.p2align	2
__ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillB8ne180100Ev: ; @_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE4fillB8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x19, x0
	str	x0, [sp, #8]
	bl	__ZNSt3__111char_traitsIcE3eofB8ne180100Ev
	ldr	w1, [x19, #144]
	bl	__ZNSt3__111char_traitsIcE11eq_int_typeB8ne180100Eii
	cbz	w0, LBB8_2
; %bb.1:
	mov	x0, x19
	mov	w1, #32                         ; =0x20
	bl	__ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenB8ne180100Ec
	str	w0, [x19, #144]
LBB8_2:
	ldrsb	w0, [x19, #144]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNKSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEE6failedB8ne180100Ev ; -- Begin function _ZNKSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEE6failedB8ne180100Ev
	.globl	__ZNKSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEE6failedB8ne180100Ev
	.weak_definition	__ZNKSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEE6failedB8ne180100Ev
	.p2align	2
__ZNKSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEE6failedB8ne180100Ev: ; @_ZNKSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEE6failedB8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 32
	.cfi_offset w21, -8
	.cfi_offset w22, -16
	str	x0, [sp, #8]
	ldr	x22, [x0]
	cmp	x22, #0
	cset	w0, eq
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateB8ne180100Ej ; -- Begin function _ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateB8ne180100Ej
	.globl	__ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateB8ne180100Ej
	.weak_definition	__ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateB8ne180100Ej
	.p2align	2
__ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateB8ne180100Ej: ; @_ZNSt3__19basic_iosIcNS_11char_traitsIcEEE8setstateB8ne180100Ej
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	str	w1, [sp, #4]
	bl	__ZNSt3__18ios_base8setstateB8ne180100Ej
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	___clang_call_terminate ; -- Begin function __clang_call_terminate
	.globl	___clang_call_terminate
	.weak_definition	___clang_call_terminate
	.p2align	2
___clang_call_terminate:                ; @__clang_call_terminate
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	bl	___cxa_begin_catch
	bl	__ZSt9terminatev
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNKSt3__18ios_base5widthB8ne180100Ev ; -- Begin function _ZNKSt3__18ios_base5widthB8ne180100Ev
	.globl	__ZNKSt3__18ios_base5widthB8ne180100Ev
	.weak_definition	__ZNKSt3__18ios_base5widthB8ne180100Ev
	.p2align	2
__ZNKSt3__18ios_base5widthB8ne180100Ev: ; @_ZNKSt3__18ios_base5widthB8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	ldr	x0, [x0, #24]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnB8ne180100EPKcl ; -- Begin function _ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnB8ne180100EPKcl
	.globl	__ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnB8ne180100EPKcl
	.weak_definition	__ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnB8ne180100EPKcl
	.p2align	2
__ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnB8ne180100EPKcl: ; @_ZNSt3__115basic_streambufIcNS_11char_traitsIcEEE5sputnB8ne180100EPKcl
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stp	x2, x1, [sp, #8]
	ldr	x7, [x0]
	ldr	x7, [x7, #96]
	blr	x7
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B8ne180100Emc ; -- Begin function _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B8ne180100Emc
	.globl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B8ne180100Emc
	.weak_def_can_be_hidden	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B8ne180100Emc
	.p2align	2
__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B8ne180100Emc: ; @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC1B8ne180100Emc
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	str	x1, [sp, #16]
	strb	w2, [sp, #15]
	bl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2B8ne180100Emc
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataB8ne180100Ev ; -- Begin function _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataB8ne180100Ev
	.globl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataB8ne180100Ev
	.weak_definition	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataB8ne180100Ev
	.p2align	2
__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataB8ne180100Ev: ; @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE4dataB8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	bl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerB8ne180100Ev
	bl	__ZNSt3__112__to_addressB8ne180100IcEEPT_S2_
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__18ios_base5widthB8ne180100El ; -- Begin function _ZNSt3__18ios_base5widthB8ne180100El
	.globl	__ZNSt3__18ios_base5widthB8ne180100El
	.weak_definition	__ZNSt3__18ios_base5widthB8ne180100El
	.p2align	2
__ZNSt3__18ios_base5widthB8ne180100El:  ; @_ZNSt3__18ios_base5widthB8ne180100El
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	.cfi_def_cfa_offset 48
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x30, x0
	stp	x1, x0, [sp, #16]
	ldr	x0, [x0, #24]
	str	x0, [sp, #8]
	str	x1, [x30, #24]
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2B8ne180100Emc ; -- Begin function _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2B8ne180100Emc
	.globl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2B8ne180100Emc
	.weak_def_can_be_hidden	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2B8ne180100Emc
	.p2align	2
__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2B8ne180100Emc: ; @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEEC2B8ne180100Emc
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #64
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x19, x0
	stp	x1, x0, [sp, #16]
	strb	w2, [sp, #15]
	add	x1, sp, #14
	add	x2, sp, #13
	bl	__ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC1B8ne180100INS_18__default_init_tagESA_EEOT_OT0_
	ldr	x1, [sp, #16]
	ldrsb	w2, [sp, #15]
	bl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE6__initEmc
	mov	x0, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC1B8ne180100INS_18__default_init_tagESA_EEOT_OT0_ ; -- Begin function _ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC1B8ne180100INS_18__default_init_tagESA_EEOT_OT0_
	.weak_def_can_be_hidden	__ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC1B8ne180100INS_18__default_init_tagESA_EEOT_OT0_
	.p2align	2
__ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC1B8ne180100INS_18__default_init_tagESA_EEOT_OT0_: ; @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC1B8ne180100INS_18__default_init_tagESA_EEOT_OT0_
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stp	x2, x1, [sp, #8]
	bl	__ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC2B8ne180100INS_18__default_init_tagESA_EEOT_OT0_
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC2B8ne180100INS_18__default_init_tagESA_EEOT_OT0_ ; -- Begin function _ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC2B8ne180100INS_18__default_init_tagESA_EEOT_OT0_
	.weak_def_can_be_hidden	__ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC2B8ne180100INS_18__default_init_tagESA_EEOT_OT0_
	.p2align	2
__ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC2B8ne180100INS_18__default_init_tagESA_EEOT_OT0_: ; @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_EC2B8ne180100INS_18__default_init_tagESA_EEOT_OT0_
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	stur	x0, [x29, #-8]
	stp	x2, x1, [sp, #8]
	bl	__ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EEC2B8ne180100ENS_18__default_init_tagE
	bl	__ZNSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EEC2B8ne180100ENS_18__default_init_tagE
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EEC2B8ne180100ENS_18__default_init_tagE ; -- Begin function _ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EEC2B8ne180100ENS_18__default_init_tagE
	.globl	__ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EEC2B8ne180100ENS_18__default_init_tagE
	.weak_def_can_be_hidden	__ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EEC2B8ne180100ENS_18__default_init_tagE
	.p2align	2
__ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EEC2B8ne180100ENS_18__default_init_tagE: ; @_ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EEC2B8ne180100ENS_18__default_init_tagE
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp], #16
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EEC2B8ne180100ENS_18__default_init_tagE ; -- Begin function _ZNSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EEC2B8ne180100ENS_18__default_init_tagE
	.globl	__ZNSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EEC2B8ne180100ENS_18__default_init_tagE
	.weak_def_can_be_hidden	__ZNSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EEC2B8ne180100ENS_18__default_init_tagE
	.p2align	2
__ZNSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EEC2B8ne180100ENS_18__default_init_tagE: ; @_ZNSt3__122__compressed_pair_elemINS_9allocatorIcEELi1ELb1EEC2B8ne180100ENS_18__default_init_tagE
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp]
	bl	__ZNSt3__19allocatorIcEC2B8ne180100Ev
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__19allocatorIcEC2B8ne180100Ev ; -- Begin function _ZNSt3__19allocatorIcEC2B8ne180100Ev
	.globl	__ZNSt3__19allocatorIcEC2B8ne180100Ev
	.weak_def_can_be_hidden	__ZNSt3__19allocatorIcEC2B8ne180100Ev
	.p2align	2
__ZNSt3__19allocatorIcEC2B8ne180100Ev:  ; @_ZNSt3__19allocatorIcEC2B8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	bl	__ZNSt3__116__non_trivial_ifILb1ENS_9allocatorIcEEEC2B8ne180100Ev
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__116__non_trivial_ifILb1ENS_9allocatorIcEEEC2B8ne180100Ev ; -- Begin function _ZNSt3__116__non_trivial_ifILb1ENS_9allocatorIcEEEC2B8ne180100Ev
	.globl	__ZNSt3__116__non_trivial_ifILb1ENS_9allocatorIcEEEC2B8ne180100Ev
	.weak_def_can_be_hidden	__ZNSt3__116__non_trivial_ifILb1ENS_9allocatorIcEEEC2B8ne180100Ev
	.p2align	2
__ZNSt3__116__non_trivial_ifILb1ENS_9allocatorIcEEEC2B8ne180100Ev: ; @_ZNSt3__116__non_trivial_ifILb1ENS_9allocatorIcEEEC2B8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__112__to_addressB8ne180100IcEEPT_S2_ ; -- Begin function _ZNSt3__112__to_addressB8ne180100IcEEPT_S2_
	.globl	__ZNSt3__112__to_addressB8ne180100IcEEPT_S2_
	.weak_definition	__ZNSt3__112__to_addressB8ne180100IcEEPT_S2_
	.p2align	2
__ZNSt3__112__to_addressB8ne180100IcEEPT_S2_: ; @_ZNSt3__112__to_addressB8ne180100IcEEPT_S2_
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerB8ne180100Ev ; -- Begin function _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerB8ne180100Ev
	.globl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerB8ne180100Ev
	.weak_definition	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerB8ne180100Ev
	.p2align	2
__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerB8ne180100Ev: ; @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE13__get_pointerB8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #48
	stp	x20, x19, [sp, #16]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #32]             ; 16-byte Folded Spill
	add	x29, sp, #32
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	mov	x19, x0
	str	x0, [sp, #8]
	bl	__ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__is_longB8ne180100Ev
	cbz	w0, LBB25_2
; %bb.1:
	mov	x0, x19
	bl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__get_long_pointerB8ne180100Ev
	b	LBB25_3
LBB25_2:
	mov	x0, x19
	bl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE19__get_short_pointerB8ne180100Ev
LBB25_3:
	ldp	x29, x30, [sp, #32]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #48
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__is_longB8ne180100Ev ; -- Begin function _ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__is_longB8ne180100Ev
	.globl	__ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__is_longB8ne180100Ev
	.weak_definition	__ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__is_longB8ne180100Ev
	.p2align	2
__ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__is_longB8ne180100Ev: ; @_ZNKSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE9__is_longB8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	bl	__ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ne180100Ev
	ldrb	w4, [x0, #23]
	lsr	w0, w4, #7
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__get_long_pointerB8ne180100Ev ; -- Begin function _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__get_long_pointerB8ne180100Ev
	.globl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__get_long_pointerB8ne180100Ev
	.weak_definition	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__get_long_pointerB8ne180100Ev
	.p2align	2
__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__get_long_pointerB8ne180100Ev: ; @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE18__get_long_pointerB8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	bl	__ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ne180100Ev
	ldr	x0, [x0]
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE19__get_short_pointerB8ne180100Ev ; -- Begin function _ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE19__get_short_pointerB8ne180100Ev
	.globl	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE19__get_short_pointerB8ne180100Ev
	.weak_definition	__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE19__get_short_pointerB8ne180100Ev
	.p2align	2
__ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE19__get_short_pointerB8ne180100Ev: ; @_ZNSt3__112basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE19__get_short_pointerB8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	bl	__ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ne180100Ev
	bl	__ZNSt3__114pointer_traitsIPcE10pointer_toB8ne180100ERc
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ne180100Ev ; -- Begin function _ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ne180100Ev
	.globl	__ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ne180100Ev
	.weak_definition	__ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ne180100Ev
	.p2align	2
__ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ne180100Ev: ; @_ZNKSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	bl	__ZNKSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ne180100Ev
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNKSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ne180100Ev ; -- Begin function _ZNKSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ne180100Ev
	.globl	__ZNKSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ne180100Ev
	.weak_definition	__ZNKSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ne180100Ev
	.p2align	2
__ZNKSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ne180100Ev: ; @_ZNKSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ne180100Ev ; -- Begin function _ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ne180100Ev
	.globl	__ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ne180100Ev
	.weak_definition	__ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ne180100Ev
	.p2align	2
__ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ne180100Ev: ; @_ZNSt3__117__compressed_pairINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repES5_E5firstB8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	bl	__ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ne180100Ev
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ne180100Ev ; -- Begin function _ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ne180100Ev
	.globl	__ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ne180100Ev
	.weak_definition	__ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ne180100Ev
	.p2align	2
__ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ne180100Ev: ; @_ZNSt3__122__compressed_pair_elemINS_12basic_stringIcNS_11char_traitsIcEENS_9allocatorIcEEE5__repELi0ELb0EE5__getB8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__114pointer_traitsIPcE10pointer_toB8ne180100ERc ; -- Begin function _ZNSt3__114pointer_traitsIPcE10pointer_toB8ne180100ERc
	.globl	__ZNSt3__114pointer_traitsIPcE10pointer_toB8ne180100ERc
	.weak_definition	__ZNSt3__114pointer_traitsIPcE10pointer_toB8ne180100ERc
	.p2align	2
__ZNSt3__114pointer_traitsIPcE10pointer_toB8ne180100ERc: ; @_ZNSt3__114pointer_traitsIPcE10pointer_toB8ne180100ERc
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC2B8ne180100ERNS_13basic_ostreamIcS2_EE ; -- Begin function _ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC2B8ne180100ERNS_13basic_ostreamIcS2_EE
	.globl	__ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC2B8ne180100ERNS_13basic_ostreamIcS2_EE
	.weak_def_can_be_hidden	__ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC2B8ne180100ERNS_13basic_ostreamIcS2_EE
	.p2align	2
__ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC2B8ne180100ERNS_13basic_ostreamIcS2_EE: ; @_ZNSt3__119ostreambuf_iteratorIcNS_11char_traitsIcEEEC2B8ne180100ERNS_13basic_ostreamIcS2_EE
Lfunc_begin2:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception2
; %bb.0:
	sub	sp, sp, #64
	stp	x22, x21, [sp, #16]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #32]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #48]             ; 16-byte Folded Spill
	add	x29, sp, #48
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w21, -40
	.cfi_offset w22, -48
	mov	x19, x0
	stp	x1, x0, [sp]
	ldr	x11, [x1]
	ldur	x4, [x11, #-24]
Ltmp27:
	add	x0, x1, x4
	bl	__ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5rdbufB8ne180100Ev
Ltmp28:
; %bb.1:
	str	x0, [x19]
	mov	x0, x19
	ldp	x29, x30, [sp, #48]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #32]             ; 16-byte Folded Reload
	ldp	x22, x21, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #64
	ret
LBB34_2:
Ltmp29:
	bl	___clang_call_terminate
Lfunc_end2:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table34:
Lexception2:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	155                             ; @TType Encoding = indirect pcrel sdata4
	.uleb128 Lttbase1-Lttbaseref1
Lttbaseref1:
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end2-Lcst_begin2
Lcst_begin2:
	.uleb128 Ltmp27-Lfunc_begin2            ; >> Call Site 1 <<
	.uleb128 Ltmp28-Ltmp27                  ;   Call between Ltmp27 and Ltmp28
	.uleb128 Ltmp29-Lfunc_begin2            ;     jumps to Ltmp29
	.byte	1                               ;   On action: 1
Lcst_end2:
	.byte	1                               ; >> Action Record 1 <<
                                        ;   Catch TypeInfo 1
	.byte	0                               ;   No further actions
	.p2align	2, 0x0
                                        ; >> Catch TypeInfos <<
	.long	0                               ; TypeInfo 1
Lttbase1:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5rdbufB8ne180100Ev ; -- Begin function _ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5rdbufB8ne180100Ev
	.globl	__ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5rdbufB8ne180100Ev
	.weak_definition	__ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5rdbufB8ne180100Ev
	.p2align	2
__ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5rdbufB8ne180100Ev: ; @_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5rdbufB8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	bl	__ZNKSt3__18ios_base5rdbufB8ne180100Ev
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNKSt3__18ios_base5rdbufB8ne180100Ev ; -- Begin function _ZNKSt3__18ios_base5rdbufB8ne180100Ev
	.globl	__ZNKSt3__18ios_base5rdbufB8ne180100Ev
	.weak_definition	__ZNKSt3__18ios_base5rdbufB8ne180100Ev
	.p2align	2
__ZNKSt3__18ios_base5rdbufB8ne180100Ev: ; @_ZNKSt3__18ios_base5rdbufB8ne180100Ev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	str	x0, [sp, #8]
	ldr	x0, [x0, #40]
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__111char_traitsIcE11eq_int_typeB8ne180100Eii ; -- Begin function _ZNSt3__111char_traitsIcE11eq_int_typeB8ne180100Eii
	.globl	__ZNSt3__111char_traitsIcE11eq_int_typeB8ne180100Eii
	.weak_definition	__ZNSt3__111char_traitsIcE11eq_int_typeB8ne180100Eii
	.p2align	2
__ZNSt3__111char_traitsIcE11eq_int_typeB8ne180100Eii: ; @_ZNSt3__111char_traitsIcE11eq_int_typeB8ne180100Eii
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #16
	.cfi_def_cfa_offset 16
	stp	w1, w0, [sp, #8]
	cmp	w0, w1
	cset	w0, eq
	add	sp, sp, #16
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__111char_traitsIcE3eofB8ne180100Ev ; -- Begin function _ZNSt3__111char_traitsIcE3eofB8ne180100Ev
	.globl	__ZNSt3__111char_traitsIcE3eofB8ne180100Ev
	.weak_definition	__ZNSt3__111char_traitsIcE3eofB8ne180100Ev
	.p2align	2
__ZNSt3__111char_traitsIcE3eofB8ne180100Ev: ; @_ZNSt3__111char_traitsIcE3eofB8ne180100Ev
	.cfi_startproc
; %bb.0:
	mov	w0, #-1                         ; =0xffffffff
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenB8ne180100Ec ; -- Begin function _ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenB8ne180100Ec
	.globl	__ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenB8ne180100Ec
	.weak_definition	__ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenB8ne180100Ec
	.p2align	2
__ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenB8ne180100Ec: ; @_ZNKSt3__19basic_iosIcNS_11char_traitsIcEEE5widenB8ne180100Ec
Lfunc_begin3:
	.cfi_startproc
	.cfi_personality 155, ___gxx_personality_v0
	.cfi_lsda 16, Lexception3
; %bb.0:
	sub	sp, sp, #96
	stp	x24, x23, [sp, #48]             ; 16-byte Folded Spill
	stp	x20, x19, [sp, #64]             ; 16-byte Folded Spill
	stp	x29, x30, [sp, #80]             ; 16-byte Folded Spill
	add	x29, sp, #80
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w19, -24
	.cfi_offset w20, -32
	.cfi_offset w23, -40
	.cfi_offset w24, -48
	str	x0, [sp, #40]
	strb	w1, [sp, #39]
	add	x8, sp, #24
	bl	__ZNKSt3__18ios_base6getlocEv
Ltmp32:
	add	x0, sp, #24
	bl	__ZNSt3__19use_facetB8ne180100INS_5ctypeIcEEEERKT_RKNS_6localeE
Ltmp33:
; %bb.1:
	ldrsb	w1, [sp, #39]
Ltmp34:
	bl	__ZNKSt3__15ctypeIcE5widenB8ne180100Ec
Ltmp35:
; %bb.2:
	mov	x23, x0
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
	mov	x0, x23
	ldp	x29, x30, [sp, #80]             ; 16-byte Folded Reload
	ldp	x20, x19, [sp, #64]             ; 16-byte Folded Reload
	ldp	x24, x23, [sp, #48]             ; 16-byte Folded Reload
	add	sp, sp, #96
	ret
LBB39_3:
Ltmp36:
	mov	x19, x1
	str	x0, [sp, #16]
	str	w19, [sp, #12]
	add	x0, sp, #24
	bl	__ZNSt3__16localeD1Ev
	ldr	x0, [sp, #16]
	bl	__Unwind_Resume
Lfunc_end3:
	.cfi_endproc
	.section	__TEXT,__gcc_except_tab
	.p2align	2, 0x0
GCC_except_table39:
Lexception3:
	.byte	255                             ; @LPStart Encoding = omit
	.byte	255                             ; @TType Encoding = omit
	.byte	1                               ; Call site Encoding = uleb128
	.uleb128 Lcst_end3-Lcst_begin3
Lcst_begin3:
	.uleb128 Lfunc_begin3-Lfunc_begin3      ; >> Call Site 1 <<
	.uleb128 Ltmp32-Lfunc_begin3            ;   Call between Lfunc_begin3 and Ltmp32
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp32-Lfunc_begin3            ; >> Call Site 2 <<
	.uleb128 Ltmp35-Ltmp32                  ;   Call between Ltmp32 and Ltmp35
	.uleb128 Ltmp36-Lfunc_begin3            ;     jumps to Ltmp36
	.byte	0                               ;   On action: cleanup
	.uleb128 Ltmp35-Lfunc_begin3            ; >> Call Site 3 <<
	.uleb128 Lfunc_end3-Ltmp35              ;   Call between Ltmp35 and Lfunc_end3
	.byte	0                               ;     has no landing pad
	.byte	0                               ;   On action: cleanup
Lcst_end3:
	.p2align	2, 0x0
                                        ; -- End function
	.section	__TEXT,__text,regular,pure_instructions
	.private_extern	__ZNSt3__19use_facetB8ne180100INS_5ctypeIcEEEERKT_RKNS_6localeE ; -- Begin function _ZNSt3__19use_facetB8ne180100INS_5ctypeIcEEEERKT_RKNS_6localeE
	.globl	__ZNSt3__19use_facetB8ne180100INS_5ctypeIcEEEERKT_RKNS_6localeE
	.weak_definition	__ZNSt3__19use_facetB8ne180100INS_5ctypeIcEEEERKT_RKNS_6localeE
	.p2align	2
__ZNSt3__19use_facetB8ne180100INS_5ctypeIcEEEERKT_RKNS_6localeE: ; @_ZNSt3__19use_facetB8ne180100INS_5ctypeIcEEEERKT_RKNS_6localeE
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
Lloh12:
	adrp	x1, __ZNSt3__15ctypeIcE2idE@GOTPAGE
Lloh13:
	ldr	x1, [x1, __ZNSt3__15ctypeIcE2idE@GOTPAGEOFF]
	bl	__ZNKSt3__16locale9use_facetERNS0_2idE
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.loh AdrpLdrGot	Lloh12, Lloh13
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNKSt3__15ctypeIcE5widenB8ne180100Ec ; -- Begin function _ZNKSt3__15ctypeIcE5widenB8ne180100Ec
	.globl	__ZNKSt3__15ctypeIcE5widenB8ne180100Ec
	.weak_definition	__ZNKSt3__15ctypeIcE5widenB8ne180100Ec
	.p2align	2
__ZNKSt3__15ctypeIcE5widenB8ne180100Ec: ; @_ZNKSt3__15ctypeIcE5widenB8ne180100Ec
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	strb	w1, [sp, #7]
	ldr	x14, [x0]
	ldr	x16, [x14, #56]
	blr	x16
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__18ios_base8setstateB8ne180100Ej ; -- Begin function _ZNSt3__18ios_base8setstateB8ne180100Ej
	.globl	__ZNSt3__18ios_base8setstateB8ne180100Ej
	.weak_definition	__ZNSt3__18ios_base8setstateB8ne180100Ej
	.p2align	2
__ZNSt3__18ios_base8setstateB8ne180100Ej: ; @_ZNSt3__18ios_base8setstateB8ne180100Ej
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	str	w1, [sp, #4]
	ldr	w5, [x0, #32]
	orr	w1, w5, w1
	bl	__ZNSt3__18ios_base5clearEj
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.private_extern	__ZNSt3__118__constexpr_strlenB8ne180100EPKc ; -- Begin function _ZNSt3__118__constexpr_strlenB8ne180100EPKc
	.globl	__ZNSt3__118__constexpr_strlenB8ne180100EPKc
	.weak_definition	__ZNSt3__118__constexpr_strlenB8ne180100EPKc
	.p2align	2
__ZNSt3__118__constexpr_strlenB8ne180100EPKc: ; @_ZNSt3__118__constexpr_strlenB8ne180100EPKc
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	str	x0, [sp, #8]
	bl	_strlen
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32
	ret
	.cfi_endproc
                                        ; -- End function
	.section	__TEXT,__cstring,cstring_literals
l_.str:                                 ; @.str
	.asciz	"Enter 100 integers:\n"

l_.str.1:                               ; @.str.1
	.asciz	"You entered:\n"

l_.str.2:                               ; @.str.2
	.asciz	" "

l_.str.3:                               ; @.str.3
	.asciz	"\n"

.subsections_via_symbols
