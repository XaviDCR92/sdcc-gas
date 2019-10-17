;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _rlslonglong
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __rlslonglong
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
;	../_rlslonglong.c: 35: long long _rlslonglong(long long l, char s)
;	-----------------------------------------
;	 function _rlslonglong
;	-----------------------------------------
__rlslonglong:
	sub	sp, #17
;	../_rlslonglong.c: 37: return((unsigned long long)(l) << s);
	ldw	y, (0x1c, sp)
	ldw	(0x07, sp), y
	ldw	y, (0x1a, sp)
	ldw	(0x05, sp), y
	ldw	y, (0x18, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x16, sp)
	ldw	(0x01, sp), y
	ld	a, (0x1e, sp)
	ld	(0x11, sp), a
	ldw	y, (0x05, sp)
	ldw	(0x0e, sp), y
	ldw	y, (0x03, sp)
	ldw	(0x0c, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x0a, sp), y
	ldw	x, (0x07, sp)
	ld	a, (0x11, sp)
	jreq	00104$
00103$:
	sllw	x
	rlc	(0x0f, sp)
	rlc	(0x0e, sp)
	rlc	(0x0d, sp)
	rlc	(0x0c, sp)
	rlc	(0x0b, sp)
	rlc	(0x0a, sp)
	dec	a
	jrne	00103$
00104$:
	ldw	(0x10, sp), x
	ldw	x, (0x14, sp)
	ldw	y, (0x10, sp)
	ldw	(#6, x), y
	ldw	y, (0x0e, sp)
	ldw	(#4, x), y
	ldw	y, (0x0c, sp)
	ldw	(#2, x), y
	ldw	y, (0x0a, sp)
	ldw	(x), y
;	../_rlslonglong.c: 38: }
	addw	sp, #17
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
