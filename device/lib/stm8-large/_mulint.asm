;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _mulint
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __mulint
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
;	../_mulint.c: 226: _mulint (int a, int b)
;	-----------------------------------------
;	 function _mulint
;	-----------------------------------------
__mulint:
	sub	sp, #5
;	../_mulint.c: 238: x = (union uu *)&a;
	ldw	x, sp
	addw	x, #9
	ldw	(0x03, sp), x
;	../_mulint.c: 239: y = (union uu *)&b;
	ldw	x, sp
	addw	x, #11
;	../_mulint.c: 243: t.t = (unsigned char)a * (unsigned char)b;
	ld	a, (0x0a, sp)
	ld	yl, a
	ld	a, (0x0c, sp)
	mul	y, a
	ldw	(0x01, sp), y
;	../_mulint.c: 244: t.s.hi += ((unsigned char)a * y->s.hi) + (x->s.hi * (unsigned char)b);
	ld	a, (0x01, sp)
	ld	(0x05, sp), a
	ld	a, (0x0a, sp)
	ld	yl, a
	ld	a, (x)
	mul	y, a
	ldw	x, (0x03, sp)
	ld	a, (x)
	ld	xl, a
	ld	a, (0x0c, sp)
	mul	x, a
	ld	a, yl
	pushw	x
	add	a, (2, sp)
	popw	x
	add	a, (0x05, sp)
	ld	(0x01, sp), a
;	../_mulint.c: 246: return t.t;
	ldw	x, (0x01, sp)
;	../_mulint.c: 247: }
	addw	sp, #5
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
