;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _uint2fs
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___ulong2fs
	.globl ___uint2fs
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
;	../_uint2fs.c: 54: float __uint2fs (unsigned int ui) {
;	-----------------------------------------
;	 function __uint2fs
;	-----------------------------------------
___uint2fs:
;	../_uint2fs.c: 55: return __ulong2fs(ui);
	ldw	y, (0x04, sp)
	clrw	x
	pushw	y
	pushw	x
	callf	___ulong2fs
	addw	sp, #4
;	../_uint2fs.c: 56: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
