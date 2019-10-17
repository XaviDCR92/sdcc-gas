;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _mulschar
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __mulschar
	.globl __muluschar
	.globl __mulsuchar
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
;	../_mulschar.c: 31: _mulschar (signed char x, signed char y)
;	-----------------------------------------
;	 function _mulschar
;	-----------------------------------------
__mulschar:
;	../_mulschar.c: 33: return ((int)x * (int)y);
	ld	a, (0x03, sp)
	ld	xl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xh, a
	ld	a, (0x04, sp)
	ld	yl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	yh, a
	pushw	y
	pushw	x
	call	__mulint
	addw	sp, #4
;	../_mulschar.c: 34: }
	ret
;	../_mulschar.c: 37: _muluschar (unsigned char x, unsigned char y)
;	-----------------------------------------
;	 function _muluschar
;	-----------------------------------------
__muluschar:
	sub	sp, #2
;	../_mulschar.c: 39: return ((int)((signed char)x) * (int)y);
	ld	a, (0x05, sp)
	ld	xl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xh, a
	ld	a, (0x06, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	ldw	y, (0x01, sp)
	pushw	y
	pushw	x
	call	__mulint
;	../_mulschar.c: 40: }
	addw	sp, #6
	ret
;	../_mulschar.c: 43: _mulsuchar (signed char x, signed char y)
;	-----------------------------------------
;	 function _mulsuchar
;	-----------------------------------------
__mulsuchar:
;	../_mulschar.c: 45: return ((int)((unsigned char)x) * (int)y);
	ld	a, (0x03, sp)
	clrw	y
	ld	yl, a
	ld	a, (0x04, sp)
	ld	xl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xh, a
	pushw	x
	pushw	y
	call	__mulint
	addw	sp, #4
;	../_mulschar.c: 46: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
