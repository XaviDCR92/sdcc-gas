;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module ispunct
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _isalnum
	.globl _isspace
	.globl _isprint
	.globl _ispunct
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
;	../ispunct.c: 33: int ispunct (int c)
;	-----------------------------------------
;	 function ispunct
;	-----------------------------------------
_ispunct:
;	../ispunct.c: 35: return (isprint (c) && !isspace (c) && !isalnum (c));
	ldw	x, (0x03, sp)
	pushw	x
	call	_isprint
	addw	sp, #2
	tnzw	x
	jreq	00103$
	ldw	x, (0x03, sp)
	pushw	x
	call	_isspace
	addw	sp, #2
	tnzw	x
	jrne	00103$
	ldw	x, (0x03, sp)
	pushw	x
	call	_isalnum
	addw	sp, #2
	tnzw	x
	jreq	00104$
00103$:
	clr	a
	.byte 0xc5
00104$:
	ld	a, #0x01
00105$:
	clrw	x
	ld	xl, a
;	../ispunct.c: 36: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
