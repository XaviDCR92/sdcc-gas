;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module isnan
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _isnan
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
;	../isnan.c: 33: int isnan (float f)
;	-----------------------------------------
;	 function isnan
;	-----------------------------------------
_isnan:
	sub	sp, #4
;	../isnan.c: 35: unsigned long *pl = (unsigned long *) &f;
	ldw	x, sp
	addw	x, #8
;	../isnan.c: 37: return (*pl & 0x7fffffff) > 0x7f800000;
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	x, (x)
	ldw	(0x03, sp), y
	exg	a, xl
	ld	(0x02, sp), a
	exg	a, xl
	ld	a, xh
	and	a, #0x7f
	ld	(0x01, sp), a
	clrw	x
	cpw	x, (0x03, sp)
	ld	a, #0x80
	sbc	a, (0x02, sp)
	ld	a, #0x7f
	sbc	a, (0x01, sp)
	clr	a
	rlc	a
	clrw	x
	ld	xl, a
;	../isnan.c: 38: }
	addw	sp, #4
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
