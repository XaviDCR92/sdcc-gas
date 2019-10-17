;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _fs2slong
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fs2ulong
	.globl ___fs2slong
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
;	../_fs2slong.c: 108: signed long __fs2slong (float f)
;	-----------------------------------------
;	 function __fs2slong
;	-----------------------------------------
___fs2slong:
	sub	sp, #4
;	../_fs2slong.c: 111: if (!f)
	ldw	x, (0x0a, sp)
	jrne	00102$
	ldw	x, (0x08, sp)
	sllw	x
	jrne	00102$
;	../_fs2slong.c: 112: return 0;
	clrw	x
	clrw	y
	jra	00106$
00102$:
;	../_fs2slong.c: 114: if (f<0) {
	clrw	x
	pushw	x
	clrw	x
	pushw	x
	ldw	x, (0x0e, sp)
	pushw	x
	ldw	x, (0x0e, sp)
	pushw	x
	callf	___fslt
	addw	sp, #8
	tnz	a
	jreq	00104$
;	../_fs2slong.c: 115: return -__fs2ulong(-f);
	ldw	y, (0x0a, sp)
	ldw	x, (0x08, sp)
	sllw	x
	ccf
	rrcw	x
	pushw	y
	pushw	x
	callf	___fs2ulong
	addw	sp, #4
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
	ldw	x, (0x03, sp)
	negw	x
	ldw	y, (0x01, sp)
	jrnc	00121$
	incw	y
00121$:
	negw	y
	jra	00106$
00104$:
;	../_fs2slong.c: 117: return __fs2ulong(f);
	ldw	x, (0x0a, sp)
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	callf	___fs2ulong
	addw	sp, #4
00106$:
;	../_fs2slong.c: 119: }
	addw	sp, #4
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
