;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module labs
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _labs
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
;	../labs.c: 63: long int labs(long int j)
;	-----------------------------------------
;	 function labs
;	-----------------------------------------
_labs:
;	../labs.c: 65: return (j < 0) ? -j : j;
	tnz	(0x04, sp)
	jrpl	00103$
	ldw	x, (0x06, sp)
	negw	x
	ldw	y, (0x04, sp)
	jrnc	00111$
	incw	y
00111$:
	negw	y
	jra	00104$
00103$:
	ldw	x, (0x06, sp)
	ldw	y, (0x04, sp)
00104$:
;	../labs.c: 66: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
