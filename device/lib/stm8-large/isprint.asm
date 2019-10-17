;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module isprint
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _isprint
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
;	../isprint.c: 33: int isprint (int c)
;	-----------------------------------------
;	 function isprint
;	-----------------------------------------
_isprint:
;	../isprint.c: 35: return (c >= ' ' && c <= '~');
	ldw	x, (0x04, sp)
	cpw	x, #0x0020
	jrslt	00103$
	cpw	x, #0x007e
	jrsle	00104$
00103$:
	clr	a
	.byte 0xc5
00104$:
	ld	a, #0x01
00105$:
	clrw	x
	ld	xl, a
;	../isprint.c: 36: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
