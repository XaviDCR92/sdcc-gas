;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _sint2fs
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___slong2fs
	.globl ___sint2fs
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
;	../_sint2fs.c: 54: float __sint2fs (signed int si) {
;	-----------------------------------------
;	 function __sint2fs
;	-----------------------------------------
___sint2fs:
;	../_sint2fs.c: 55: return __slong2fs(si);
	ldw	y, (0x04, sp)
	clrw	x
	tnzw	y
	jrpl	00103$
	decw	x
00103$:
	pushw	y
	pushw	x
	callf	___slong2fs
	addw	sp, #4
;	../_sint2fs.c: 56: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
