;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module abs
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _abs
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
;	../abs.c: 54: int abs(int j)
;	-----------------------------------------
;	 function abs
;	-----------------------------------------
_abs:
;	../abs.c: 56: return (j < 0) ? -j : j;
	tnz	(0x03, sp)
	jrpl	00103$
	ldw	x, (0x03, sp)
	negw	x
	ret
00103$:
	ldw	x, (0x03, sp)
;	../abs.c: 57: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
