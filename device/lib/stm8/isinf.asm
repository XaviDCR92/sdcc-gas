;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module isinf
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _isinf
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
;	../isinf.c: 33: int isinf (float f)
;	-----------------------------------------
;	 function isinf
;	-----------------------------------------
_isinf:
;	../isinf.c: 35: unsigned long *pl = (unsigned long *) &f;
	ldw	x, sp
	addw	x, #3
;	../isinf.c: 36: return *pl == 0x7f800000 || *pl == 0xff800000;
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	x, (x)
	tnzw	y
	jrne	00117$
	cpw	x, #0x7f80
	jreq	00104$
00117$:
	tnzw	y
	jrne	00120$
	cpw	x, #0xff80
	jreq	00104$
00120$:
	clr	a
	.byte 0xc5
00104$:
	ld	a, #0x01
00105$:
	clrw	x
	ld	xl, a
;	../isinf.c: 37: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
