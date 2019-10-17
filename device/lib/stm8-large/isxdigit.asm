;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module isxdigit
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _isxdigit
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
;	../isxdigit.c: 33: int isxdigit (int c)
;	-----------------------------------------
;	 function isxdigit
;	-----------------------------------------
_isxdigit:
;	../isxdigit.c: 35: return (c >= '0' && c <= '9' || c >= 'a' && c <= 'f' || c >= 'A' && c <= 'F');
	ldw	x, (0x04, sp)
	cpw	x, #0x0030
	jrslt	00111$
	cpw	x, #0x0039
	jrsle	00104$
00111$:
	ldw	x, (0x04, sp)
	cpw	x, #0x0061
	jrslt	00108$
	cpw	x, #0x0066
	jrsle	00104$
00108$:
	ldw	x, (0x04, sp)
	cpw	x, #0x0041
	jrslt	00103$
	cpw	x, #0x0046
	jrsle	00104$
00103$:
	clr	a
	.byte 0xc5
00104$:
	ld	a, #0x01
00105$:
	clrw	x
	ld	xl, a
;	../isxdigit.c: 36: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
