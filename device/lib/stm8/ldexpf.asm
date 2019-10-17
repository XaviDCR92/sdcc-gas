;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module ldexpf
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ldexpf
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area DABS (ABS)

; default segment ordering for linker
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area CONST
	.area INITIALIZER
	.area CODE

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area HOME
	.area GSINIT
	.area GSFINAL
	.area GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area HOME
	.area HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area CODE
;	../ldexpf.c: 34: float ldexpf(float x, int pw2)
;	-----------------------------------------
;	 function ldexpf
;	-----------------------------------------
_ldexpf:
	sub	sp, #16
;	../ldexpf.c: 39: fl.f = x;
	ldw	y, (0x15, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x13, sp)
	ldw	(0x01, sp), y
;	../ldexpf.c: 41: e=(fl.l >> 23) & 0x000000ff;
	ldw	y, (0x03, sp)
	ldw	x, (0x01, sp)
	clr	a
	tnzw	x
	jrpl	00103$
	dec	a
00103$:
	push	a
	rrwa	x
	rrwa	y
	ld	a, (1, sp)
	rrwa	x
	rrwa	y
	ld	a, (1, sp)
	rrwa	x
	rrwa	y
	sll	a
	rlcw	y
	rlcw	x
	pop	a
	clr	a
	clrw	x
	exg	a, yl
	ld	(0x0c, sp), a
	exg	a, yl
	ld	(0x0b, sp), a
	ldw	(0x09, sp), x
;	../ldexpf.c: 42: e+=pw2;
	ldw	x, (0x17, sp)
	ldw	(0x0f, sp), x
	clrw	x
	tnz	(0x0f, sp)
	jrpl	00104$
	decw	x
00104$:
	ldw	y, (0x0f, sp)
	addw	y, (0x0b, sp)
	ld	a, xl
	adc	a, (0x0a, sp)
	rlwa	x
	adc	a, (0x09, sp)
;	../ldexpf.c: 43: fl.l= ((e & 0xff) << 23) | (fl.l & 0x807fffff);
	clr	a
	ld	yh, a
	clrw	x
	exg	a, xl
	ld	a, yl
	exg	a, xl
	rlwa	x
	ld	a, yh
	rrwa	x
	clrw	y
	ld	a, #0x07
00105$:
	sllw	x
	dec	a
	jrne	00105$
	ldw	(0x07, sp), y
	ldw	(0x05, sp), x
	ldw	y, (0x03, sp)
	ldw	(0x0b, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x09, sp), y
	ld	a, (0x0b, sp)
	ld	(0x0f, sp), a
	ld	a, (0x0c, sp)
	ld	(0x10, sp), a
	ld	a, (0x0a, sp)
	and	a, #0x7f
	ld	(0x0e, sp), a
	ld	a, (0x09, sp)
	and	a, #0x80
	or	a, (0x05, sp)
	ld	yh, a
	ld	a, (0x08, sp)
	or	a, (0x10, sp)
	ld	xl, a
	ld	a, (0x07, sp)
	or	a, (0x0f, sp)
	ld	xh, a
	ld	a, (0x06, sp)
	or	a, (0x0e, sp)
	ld	yl, a
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	../ldexpf.c: 45: return(fl.f);
	ldw	x, (0x03, sp)
	ldw	y, (0x01, sp)
;	../ldexpf.c: 46: }
	addw	sp, #16
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
