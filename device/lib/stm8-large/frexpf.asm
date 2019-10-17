;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module frexpf
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _frexpf
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
;	../frexpf.c: 34: float frexpf(float x, int *pw2)
;	-----------------------------------------
;	 function frexpf
;	-----------------------------------------
_frexpf:
	sub	sp, #8
;	../frexpf.c: 39: fl.f=x;
	ldw	y, (0x0e, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x0c, sp)
	ldw	(0x01, sp), y
;	../frexpf.c: 41: i  = ( fl.l >> 23) & 0x000000ff;
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
;	../frexpf.c: 42: i -= 0x7e;
	ld	yh, a
	subw	y, #0x007e
	ld	a, xl
	sbc	a, #0x00
	rlwa	x
	sbc	a, #0x00
	ldw	(0x07, sp), y
	exg	a, xl
	ld	(0x06, sp), a
	exg	a, xl
	ld	(0x05, sp), a
;	../frexpf.c: 43: *pw2 = i;
	ldw	x, (0x10, sp)
	ldw	y, (0x07, sp)
	ldw	(x), y
;	../frexpf.c: 44: fl.l &= 0x807fffff; /* strip all exponent bits */
	ldw	y, (0x03, sp)
	ldw	x, (0x01, sp)
	ld	a, xl
	and	a, #0x7f
	rlwa	x
	and	a, #0x80
	ld	xh, a
	ldw	(0x03, sp), y
	ldw	(0x01, sp), x
;	../frexpf.c: 45: fl.l |= 0x3f000000; /* mantissa between 0.5 and 1 */
	ld	a, (0x04, sp)
	ld	a, (0x03, sp)
	ld	a, (0x02, sp)
	ld	a, (0x01, sp)
	ld	a, xh
	or	a, #0x3f
	ld	xh, a
	ldw	(0x03, sp), y
	ldw	(0x01, sp), x
;	../frexpf.c: 46: return(fl.f);
	ldw	x, (0x03, sp)
	ldw	y, (0x01, sp)
;	../frexpf.c: 47: }
	addw	sp, #8
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
