;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _divslonglong
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __divslonglong
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
;	../_divslonglong.c: 36: _divslonglong (long long numerator, long long denominator)
;	-----------------------------------------
;	 function _divslonglong
;	-----------------------------------------
__divslonglong:
	sub	sp, #17
;	../_divslonglong.c: 38: bool numeratorneg = (numerator < 0);
	tnz	(0x17, sp)
	jrmi	00124$
	clr	(0x11, sp)
	jra	00125$
00124$:
	ld	a, #0x01
	ld	(0x11, sp), a
00125$:
;	../_divslonglong.c: 39: bool denominatorneg = (denominator < 0);
	tnz	(0x1f, sp)
	jrmi	00126$
	clr	a
	.byte 0xc5
00126$:
	ld	a, #0x01
00127$:
;	../_divslonglong.c: 42: if (numeratorneg)
	tnz	(0x11, sp)
	jreq	00102$
;	../_divslonglong.c: 43: numerator = -numerator;
	push	a
	ld	a, (0x1f, sp)
	neg	a
	ld	(0x11, sp), a
	clr	a
	sbc	a, (0x1e, sp)
	ld	(0x10, sp), a
	clr	a
	sbc	a, (0x1d, sp)
	ld	(0x0f, sp), a
	clr	a
	sbc	a, (0x1c, sp)
	ld	(0x0e, sp), a
	clr	a
	sbc	a, (0x1b, sp)
	ld	(0x0d, sp), a
	clr	a
	sbc	a, (0x1a, sp)
	ld	(0x0c, sp), a
	ldw	x, (0x18, sp)
	jrnc	00129$
	incw	x
00129$:
	negw	x
	pop	a
	ldw	(0x17, sp), x
	ldw	y, (0x0f, sp)
	ldw	(0x1d, sp), y
	ldw	y, (0x0d, sp)
	ldw	(0x1b, sp), y
	ldw	y, (0x0b, sp)
	ldw	(0x19, sp), y
00102$:
;	../_divslonglong.c: 44: if (denominatorneg)
	tnz	a
	jreq	00104$
;	../_divslonglong.c: 45: denominator = -denominator;
	push	a
	ld	a, (0x27, sp)
	neg	a
	ld	(0x11, sp), a
	clr	a
	sbc	a, (0x26, sp)
	ld	(0x10, sp), a
	clr	a
	sbc	a, (0x25, sp)
	ld	(0x0f, sp), a
	clr	a
	sbc	a, (0x24, sp)
	ld	(0x0e, sp), a
	clr	a
	sbc	a, (0x23, sp)
	ld	(0x0d, sp), a
	clr	a
	sbc	a, (0x22, sp)
	ld	(0x0c, sp), a
	ldw	x, (0x20, sp)
	jrnc	00131$
	incw	x
00131$:
	negw	x
	pop	a
	ldw	(0x1f, sp), x
	ldw	y, (0x0f, sp)
	ldw	(0x25, sp), y
	ldw	y, (0x0d, sp)
	ldw	(0x23, sp), y
	ldw	y, (0x0b, sp)
	ldw	(0x21, sp), y
00104$:
;	../_divslonglong.c: 47: d = (unsigned long long)numerator / (unsigned long long)denominator;
	ldw	y, (0x1d, sp)
	ldw	(0x07, sp), y
	ldw	y, (0x1b, sp)
	ldw	(0x05, sp), y
	ldw	y, (0x19, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x17, sp)
	ldw	(0x01, sp), y
	ldw	y, (0x25, sp)
	ldw	(0x0f, sp), y
	ldw	y, (0x23, sp)
	ldw	(0x0d, sp), y
	ldw	y, (0x21, sp)
	ldw	(0x0b, sp), y
	ldw	y, (0x1f, sp)
	push	a
	ldw	x, (0x10, sp)
	pushw	x
	ldw	x, (0x10, sp)
	pushw	x
	ldw	x, (0x10, sp)
	pushw	x
	pushw	y
	ldw	x, (0x10, sp)
	pushw	x
	ldw	x, (0x10, sp)
	pushw	x
	ldw	x, (0x10, sp)
	pushw	x
	ldw	x, (0x10, sp)
	pushw	x
	ldw	x, sp
	addw	x, #26
	pushw	x
	callf	__divulonglong
	addw	sp, #18
	pop	a
	ldw	y, (0x0f, sp)
	ldw	(0x07, sp), y
	ldw	y, (0x0d, sp)
	ldw	(0x05, sp), y
	ldw	y, (0x0b, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x09, sp)
	ldw	(0x01, sp), y
;	../_divslonglong.c: 49: return ((numeratorneg ^ denominatorneg) ? -d : d);
	xor	a, (0x11, sp)
	ld	(0x11, sp), a
	jreq	00107$
	ld	a, (0x08, sp)
	neg	a
	ld	(0x11, sp), a
	clr	a
	sbc	a, (0x07, sp)
	ld	(0x10, sp), a
	clr	a
	sbc	a, (0x06, sp)
	ld	(0x0f, sp), a
	clr	a
	sbc	a, (0x05, sp)
	ld	(0x0e, sp), a
	clr	a
	sbc	a, (0x04, sp)
	ld	(0x0d, sp), a
	clr	a
	sbc	a, (0x03, sp)
	ld	(0x0c, sp), a
	clr	a
	sbc	a, (0x02, sp)
	ld	(0x0b, sp), a
	clr	a
	sbc	a, (0x01, sp)
	ld	(0x0a, sp), a
	jra	00108$
00107$:
	ldw	y, (0x07, sp)
	ldw	(0x10, sp), y
	ldw	y, (0x05, sp)
	ldw	(0x0e, sp), y
	ldw	y, (0x03, sp)
	ldw	(0x0c, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x0a, sp), y
00108$:
	ldw	x, (0x15, sp)
	ldw	y, (0x10, sp)
	ldw	(#6, x), y
	ldw	y, (0x0e, sp)
	ldw	(#4, x), y
	ldw	y, (0x0c, sp)
	ldw	(#2, x), y
	ldw	y, (0x0a, sp)
	ldw	(x), y
;	../_divslonglong.c: 50: }
	addw	sp, #17
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
