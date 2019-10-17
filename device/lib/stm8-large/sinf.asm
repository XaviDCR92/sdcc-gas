;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module sinf
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sincosf
	.globl _sinf
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
;	../sinf.c: 36: float sinf(float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function sinf
;	-----------------------------------------
_sinf:
;	../sinf.c: 38: if (x==0.0) return 0.0;
	ldw	x, (0x06, sp)
	jrne	00102$
	ldw	x, (0x04, sp)
	sllw	x
	jrne	00102$
	clrw	x
	clrw	y
	jra	00103$
00102$:
;	../sinf.c: 39: return sincosf(x, 0);
	push	#0x00
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	callf	_sincosf
	addw	sp, #5
00103$:
;	../sinf.c: 40: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
