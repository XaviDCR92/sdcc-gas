;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module wctob
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _wctob
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
;	../wctob.c: 35: int wctob(wint_t c)
;	-----------------------------------------
;	 function wctob
;	-----------------------------------------
_wctob:
	sub	sp, #4
;	../wctob.c: 37: if(c & 0xffffff80)
	ld	a, (0x0b, sp)
	and	a, #0x80
	ld	(0x04, sp), a
	ldw	x, (0x08, sp)
	ld	a, (0x0a, sp)
	ld	(0x03, sp), a
	ldw	y, (0x03, sp)
	jrne	00110$
	tnzw	x
	jreq	00102$
00110$:
;	../wctob.c: 38: return WEOF;
	clrw	x
	decw	x
;	../wctob.c: 39: return c;
	.byte 0xc5
00102$:
	ldw	x, (0x0a, sp)
00103$:
;	../wctob.c: 40: }
	addw	sp, #4
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
