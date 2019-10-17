;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module modff
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _modff
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
;	../modff.c: 33: float modff(float x, float * y)
;	-----------------------------------------
;	 function modff
;	-----------------------------------------
_modff:
	sub	sp, #6
;	../modff.c: 35: *y=(long)x;
	ldw	y, (0x0d, sp)
	ldw	(0x01, sp), y
	ldw	x, (0x0b, sp)
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	call	___fs2slong
	addw	sp, #4
	pushw	x
	pushw	y
	call	___slong2fs
	addw	sp, #4
	ldw	(0x05, sp), x
	ldw	x, (0x01, sp)
	ld	a, (0x06, sp)
	ld	(0x3, x), a
	ld	a, (0x05, sp)
	ld	(0x2, x), a
	ldw	(x), y
;	../modff.c: 36: return (x-*y);
	ldw	x, (0x05, sp)
	pushw	x
	pushw	y
	ldw	x, (0x0f, sp)
	pushw	x
	ldw	x, (0x0f, sp)
	pushw	x
	call	___fssub
;	../modff.c: 37: }
	addw	sp, #14
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
