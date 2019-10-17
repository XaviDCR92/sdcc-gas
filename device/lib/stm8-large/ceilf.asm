;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module ceilf
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ceilf
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
;	../ceilf.c: 33: float ceilf(float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function ceilf
;	-----------------------------------------
_ceilf:
	sub	sp, #8
;	../ceilf.c: 36: r=x;
	ldw	x, (0x0e, sp)
	pushw	x
	ldw	x, (0x0e, sp)
	pushw	x
	callf	___fs2slong
	addw	sp, #4
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	../ceilf.c: 38: return r;
	ldw	x, (0x03, sp)
	pushw	x
	ldw	x, (0x03, sp)
	pushw	x
	callf	___slong2fs
	addw	sp, #4
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
;	../ceilf.c: 37: if (r<0)
	tnz	(0x01, sp)
	jrpl	00102$
;	../ceilf.c: 38: return r;
	ldw	x, (0x07, sp)
	ldw	y, (0x05, sp)
	jra	00104$
00102$:
;	../ceilf.c: 40: return (r+((r<x)?1:0));
	ldw	x, (0x0e, sp)
	pushw	x
	ldw	x, (0x0e, sp)
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	callf	___fslt
	addw	sp, #8
	tnz	a
	jreq	00106$
	clrw	x
	incw	x
	.byte 0x21
00106$:
	clrw	x
00107$:
	exgw	x, y
	clrw	x
	tnzw	y
	jrpl	00120$
	decw	x
00120$:
	addw	y, (0x03, sp)
	ld	a, xl
	adc	a, (0x02, sp)
	rlwa	x
	adc	a, (0x01, sp)
	ld	xh, a
	pushw	y
	pushw	x
	callf	___slong2fs
	addw	sp, #4
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
	ldw	x, (0x07, sp)
	ldw	y, (0x05, sp)
00104$:
;	../ceilf.c: 41: }
	addw	sp, #8
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
