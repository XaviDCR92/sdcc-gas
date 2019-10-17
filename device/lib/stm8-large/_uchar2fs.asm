;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _uchar2fs
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___ulong2fs
	.globl ___uchar2fs
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
;	../_uchar2fs.c: 55: float __uchar2fs (unsigned char uc) {
;	-----------------------------------------
;	 function __uchar2fs
;	-----------------------------------------
___uchar2fs:
;	../_uchar2fs.c: 56: return __ulong2fs(uc);
	clrw	x
	ld	a, (0x04, sp)
	ld	xl, a
	clrw	y
	pushw	x
	pushw	y
	callf	___ulong2fs
	addw	sp, #4
;	../_uchar2fs.c: 57: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
