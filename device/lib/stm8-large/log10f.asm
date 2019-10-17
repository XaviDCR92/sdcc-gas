;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module log10f
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _logf
	.globl _log10f
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
;	../log10f.c: 34: float log10f(float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function log10f
;	-----------------------------------------
_log10f:
;	../log10f.c: 36: return logf(x)*0.4342944819;
	ldw	x, (0x06, sp)
	pushw	x
	ldw	x, (0x06, sp)
	pushw	x
	callf	_logf
	addw	sp, #4
	pushw	x
	pushw	y
	push	#0xd9
	push	#0x5b
	push	#0xde
	push	#0x3e
	callf	___fsmul
	addw	sp, #8
;	../log10f.c: 37: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
