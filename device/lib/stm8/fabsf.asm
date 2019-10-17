;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module fabsf
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _fabsf
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
;	../fabsf.c: 34: float fabsf(float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function fabsf
;	-----------------------------------------
_fabsf:
	sub	sp, #4
;	../fabsf.c: 38: fl.f = x;
	ldw	y, (0x09, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x07, sp)
	ldw	(0x01, sp), y
;	../fabsf.c: 39: fl.l &= 0x7fffffff;
	ldw	y, (0x03, sp)
	ldw	x, (0x01, sp)
	sllw	x
	srlw	x
	ldw	(0x03, sp), y
	ldw	(0x01, sp), x
;	../fabsf.c: 40: return fl.f;
	ldw	x, (0x03, sp)
	ldw	y, (0x01, sp)
;	../fabsf.c: 41: }
	addw	sp, #4
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
