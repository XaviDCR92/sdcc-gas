;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _strcmp
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcmp
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
;	../_strcmp.c: 34: int strcmp ( const char * asrc, const char * adst )
;	-----------------------------------------
;	 function strcmp
;	-----------------------------------------
_strcmp:
	sub	sp, #8
;	../_strcmp.c: 40: const char * src = asrc;
	ldw	y, (0x0c, sp)
	ldw	(0x01, sp), y
;	../_strcmp.c: 41: const char * dst = adst;
	ldw	y, (0x0e, sp)
	ldw	(0x03, sp), y
;	../_strcmp.c: 43: while( ! (*src - *dst) && *dst)
00102$:
	ldw	x, (0x01, sp)
	ld	a, (x)
	clrw	x
	ld	xl, a
	ldw	y, (0x03, sp)
	ld	a, (y)
	ld	(0x06, sp), a
	clr	(0x05, sp)
	subw	x, (0x05, sp)
	ldw	(0x07, sp), x
	jrne	00104$
	tnz	a
	jreq	00104$
;	../_strcmp.c: 44: ++src, ++dst;
	ldw	x, (0x01, sp)
	incw	x
	ldw	(0x07, sp), x
	ldw	(0x01, sp), x
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00102$
00104$:
;	../_strcmp.c: 46: return *src - *dst;
	ldw	x, (0x07, sp)
;	../_strcmp.c: 55: }
	addw	sp, #8
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
