;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _mullong
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __mullong
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
;	../_mullong.c: 734: _mullong (long a, long b)
;	-----------------------------------------
;	 function _mullong
;	-----------------------------------------
__mullong:
	sub	sp, #16
;	../_mullong.c: 738: t.i.hi = bcast(a)->b.b0 * bcast(b)->b.b2;           // A
	ldw	y, sp
	addw	y, #5
	ldw	x, sp
	addw	x, #20
	ldw	(0x09, sp), x
	ld	a, (0x3, x)
	ldw	x, sp
	addw	x, #24
	ldw	(0x0b, sp), x
	push	a
	ld	a, (0x1, x)
	ld	xl, a
	pop	a
	mul	x, a
	ldw	(y), x
;	../_mullong.c: 739: t.i.lo = bcast(a)->b.b0 * bcast(b)->b.b0;           // A
	addw	y, #0x0002
	ldw	x, (0x09, sp)
	ld	a, (0x3, x)
	ldw	x, (0x0b, sp)
	push	a
	ld	a, (0x3, x)
	ld	xl, a
	pop	a
	mul	x, a
	ldw	(y), x
;	../_mullong.c: 740: t.b.b3 += bcast(a)->b.b3 * bcast(b)->b.b0;          // G
	ld	a, (0x05, sp)
	ld	(0x10, sp), a
	ldw	x, (0x09, sp)
	ld	a, (x)
	ld	xl, a
	ldw	y, (0x0b, sp)
	ld	a, (0x3, y)
	mul	x, a
	ld	a, xl
	add	a, (0x10, sp)
	ld	(0x10, sp), a
;	../_mullong.c: 741: t.b.b3 += bcast(a)->b.b2 * bcast(b)->b.b1;          // F
	ld	(0x05, sp), a
	ldw	x, (0x09, sp)
	ld	a, (0x1, x)
	ld	xl, a
	ldw	y, (0x0b, sp)
	ld	a, (0x2, y)
	mul	x, a
	ld	a, xl
	add	a, (0x10, sp)
	ld	(0x05, sp), a
;	../_mullong.c: 742: t.i.hi += bcast(a)->b.b2 * bcast(b)->b.b0;          // E <- b lost in .lst
	ldw	y, (0x05, sp)
	ldw	(0x0d, sp), y
	ldw	x, (0x09, sp)
	ld	a, (0x1, x)
	ld	xl, a
	ldw	y, (0x0b, sp)
	ld	a, (0x3, y)
	mul	x, a
	addw	x, (0x0d, sp)
	ldw	(0x0f, sp), x
	ldw	(0x05, sp), x
;	../_mullong.c: 744: t.i.hi += bcast(a)->b.b1 * bcast(b)->b.b1;          // D <- b lost in .lst
	ld	a, (0x06, sp)
	ld	a, (0x05, sp)
	ldw	x, (0x09, sp)
	ld	a, (0x2, x)
	ld	xl, a
	ldw	y, (0x0b, sp)
	ld	a, (0x2, y)
	mul	x, a
	addw	x, (0x0f, sp)
	ldw	(0x05, sp), x
;	../_mullong.c: 746: bcast(a)->bi.b3 = bcast(a)->b.b1 * bcast(b)->b.b2;  // C
	ldw	y, (0x09, sp)
	ldw	x, (0x09, sp)
	ld	a, (0x2, x)
	ldw	x, (0x0b, sp)
	push	a
	ld	a, (0x1, x)
	ld	xl, a
	pop	a
	mul	x, a
	ld	a, xl
	ld	(y), a
;	../_mullong.c: 747: bcast(a)->bi.i12 = bcast(a)->b.b1 * bcast(b)->b.b0; // C
	ldw	y, (0x09, sp)
	incw	y
	ldw	x, (0x09, sp)
	ld	a, (0x2, x)
	ldw	x, (0x0b, sp)
	push	a
	ld	a, (0x3, x)
	ld	xl, a
	pop	a
	mul	x, a
	ldw	(y), x
;	../_mullong.c: 749: bcast(b)->bi.b3 = bcast(a)->b.b0 * bcast(b)->b.b3;  // B
	ldw	y, (0x0b, sp)
	ldw	x, (0x09, sp)
	ld	a, (0x3, x)
	ldw	x, (0x0b, sp)
	push	a
	ld	a, (x)
	ld	xl, a
	pop	a
	mul	x, a
	ld	a, xl
	ld	(y), a
;	../_mullong.c: 750: bcast(b)->bi.i12 = bcast(a)->b.b0 * bcast(b)->b.b1; // B
	ldw	y, (0x0b, sp)
	incw	y
	ldw	x, (0x09, sp)
	ld	a, (0x3, x)
	ldw	x, (0x0b, sp)
	push	a
	ld	a, (0x2, x)
	ld	xl, a
	pop	a
	mul	x, a
	ldw	(y), x
;	../_mullong.c: 752: bcast(b)->bi.b0 = 0;                                // B
	ldw	x, (0x0b, sp)
	clr	(0x0003, x)
;	../_mullong.c: 753: bcast(a)->bi.b0 = 0;                                // C
	ldw	x, (0x09, sp)
	clr	(0x0003, x)
;	../_mullong.c: 754: t.l += a;
	ldw	y, (0x07, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x05, sp)
	ldw	(0x01, sp), y
	ldw	x, (0x16, sp)
	ldw	(0x0b, sp), x
	ldw	x, (0x14, sp)
	ldw	y, (0x0b, sp)
	addw	y, (0x03, sp)
	ldw	(0x0f, sp), y
	ld	a, xl
	adc	a, (0x02, sp)
	ld	(0x0e, sp), a
	ld	a, xh
	adc	a, (0x01, sp)
	ld	(0x0d, sp), a
	ldw	x, (0x0f, sp)
	ldw	(0x07, sp), x
	ldw	x, (0x0d, sp)
	ldw	(0x05, sp), x
;	../_mullong.c: 756: return t.l + b;
	ld	a, (0x08, sp)
	ld	a, (0x07, sp)
	ld	a, (0x06, sp)
	ld	a, (0x05, sp)
	ldw	x, (0x1a, sp)
	ldw	(0x0b, sp), x
	ldw	x, (0x18, sp)
	ldw	y, (0x0b, sp)
	addw	y, (0x0f, sp)
	ld	a, xl
	adc	a, (0x0e, sp)
	rlwa	x
	adc	a, (0x0d, sp)
	ld	xh, a
	exgw	x, y
;	../_mullong.c: 757: }
	addw	sp, #16
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
