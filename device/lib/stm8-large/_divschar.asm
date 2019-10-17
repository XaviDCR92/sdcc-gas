;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _divschar
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __divschar
	.globl __divuschar
	.globl __divsuchar
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
;	../_divschar.c: 31: _divschar (signed char x, signed char y)
;	-----------------------------------------
;	 function _divschar
;	-----------------------------------------
__divschar:
;	../_divschar.c: 33: return ((int)x / (int)y);
	ld	a, (0x04, sp)
	ld	xl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xh, a
	ld	a, (0x05, sp)
	ld	yl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	yh, a
	pushw	y
	pushw	x
	callf	__divsint
	addw	sp, #4
;	../_divschar.c: 34: }
	retf
;	../_divschar.c: 37: _divuschar (unsigned char x, unsigned char y)
;	-----------------------------------------
;	 function _divuschar
;	-----------------------------------------
__divuschar:
	sub	sp, #2
;	../_divschar.c: 39: return ((int)((signed char)x) / (int)y);
	ld	a, (0x06, sp)
	ld	xl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xh, a
	ld	a, (0x07, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	ldw	y, (0x01, sp)
	pushw	y
	pushw	x
	callf	__divsint
;	../_divschar.c: 40: }
	addw	sp, #6
	retf
;	../_divschar.c: 43: _divsuchar (signed char x, signed char y)
;	-----------------------------------------
;	 function _divsuchar
;	-----------------------------------------
__divsuchar:
;	../_divschar.c: 45: return ((int)((unsigned char)x) / (int)y);
	ld	a, (0x04, sp)
	clrw	y
	ld	yl, a
	ld	a, (0x05, sp)
	ld	xl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xh, a
	pushw	x
	pushw	y
	callf	__divsint
	addw	sp, #4
;	../_divschar.c: 46: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
