;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module isspace
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _isspace
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
;	../isspace.c: 37: int isspace (int c)
;	-----------------------------------------
;	 function isspace
;	-----------------------------------------
_isspace:
;	../isspace.c: 39: return (c == ' ' || c == '\f' || c == '\n' || c == '\r' || c == '\t' || c == '\v');
	ldw	x, (0x04, sp)
	cpw	x, #0x0020
	jreq	00104$
	ldw	x, (0x04, sp)
	cpw	x, #0x000c
	jreq	00104$
	ldw	x, (0x04, sp)
	cpw	x, #0x000a
	jreq	00104$
	ldw	x, (0x04, sp)
	cpw	x, #0x000d
	jreq	00104$
	ldw	x, (0x04, sp)
	cpw	x, #0x0009
	jreq	00104$
	ldw	x, (0x04, sp)
	cpw	x, #0x000b
	jreq	00104$
	clr	a
	.byte 0xc5
00104$:
	ld	a, #0x01
00105$:
	clrw	x
	ld	xl, a
;	../isspace.c: 40: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
