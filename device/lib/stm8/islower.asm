;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module islower
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _islower
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
;	./../../include/ctype.h: 69: inline int islower (int c)
;	-----------------------------------------
;	 function islower
;	-----------------------------------------
_islower:
;	./../../include/ctype.h: 71: return ((unsigned char)c >= 'a' && (unsigned char)c <= 'z');
	ld	a, (0x04, sp)
	cp	a, #0x61
	jrc	00103$
	cp	a, #0x7a
	jrule	00104$
00103$:
	clr	a
	.byte 0xc5
00104$:
	ld	a, #0x01
00105$:
	clrw	x
	ld	xl, a
;	./../../include/ctype.h: 72: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
