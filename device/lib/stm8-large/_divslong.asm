;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _divslong
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __divslong
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
;	../_divslong.c: 259: _divslong (long x, long y)
;	-----------------------------------------
;	 function _divslong
;	-----------------------------------------
__divslong:
	sub	sp, #10
;	../_divslong.c: 263: r = (unsigned long)(x < 0 ? -x : x) / (unsigned long)(y < 0 ? -y : y);
	tnz	(0x0e, sp)
	jrmi	00125$
	clr	(0x01, sp)
	jra	00126$
00125$:
	ld	a, #0x01
	ld	(0x01, sp), a
00126$:
	tnz	(0x01, sp)
	jreq	00106$
	ldw	y, (0x10, sp)
	negw	y
	ldw	x, (0x0e, sp)
	jrnc	00128$
	incw	x
00128$:
	negw	x
	ldw	(0x09, sp), y
	ldw	(0x07, sp), x
	jra	00107$
00106$:
	ldw	y, (0x10, sp)
	ldw	(0x09, sp), y
	ldw	y, (0x0e, sp)
	ldw	(0x07, sp), y
00107$:
	ldw	y, (0x09, sp)
	ldw	(0x04, sp), y
	ldw	y, (0x07, sp)
	ldw	(0x02, sp), y
	tnz	(0x12, sp)
	jrmi	00129$
	clr	(0x06, sp)
	jra	00130$
00129$:
	ld	a, #0x01
	ld	(0x06, sp), a
00130$:
	tnz	(0x06, sp)
	jreq	00108$
	ld	a, (0x15, sp)
	neg	a
	ld	(0x0a, sp), a
	clr	a
	sbc	a, (0x14, sp)
	ld	(0x09, sp), a
	clr	a
	sbc	a, (0x13, sp)
	ld	(0x08, sp), a
	clr	a
	sbc	a, (0x12, sp)
	ld	(0x07, sp), a
	jra	00109$
00108$:
	ldw	y, (0x14, sp)
	ldw	(0x09, sp), y
	ldw	y, (0x12, sp)
	ldw	(0x07, sp), y
00109$:
	ldw	x, (0x09, sp)
	ldw	y, (0x07, sp)
	pushw	x
	pushw	y
	ldw	x, (0x08, sp)
	pushw	x
	ldw	x, (0x08, sp)
	pushw	x
	callf	__divulong
	addw	sp, #8
	ldw	(0x09, sp), x
	ldw	(0x07, sp), y
;	../_divslong.c: 264: if ((x < 0) ^ (y < 0))
	ld	a, (0x01, sp)
	xor	a, (0x06, sp)
	jreq	00102$
;	../_divslong.c: 265: return -r;
	ldw	x, (0x09, sp)
	negw	x
	ldw	y, (0x07, sp)
	jrnc	00133$
	incw	y
00133$:
	negw	y
	jra	00104$
00102$:
;	../_divslong.c: 267: return r;
	ldw	x, (0x09, sp)
	ldw	y, (0x07, sp)
00104$:
;	../_divslong.c: 268: }
	addw	sp, #10
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
