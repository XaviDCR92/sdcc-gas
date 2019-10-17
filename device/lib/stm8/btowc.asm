;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module btowc
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _btowc
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
;	../btowc.c: 35: wint_t btowc(int c)
;	-----------------------------------------
;	 function btowc
;	-----------------------------------------
_btowc:
;	../btowc.c: 37: if(c & 0x80)
	tnz	(0x04, sp)
	jrpl	00102$
;	../btowc.c: 38: return WEOF;
	clrw	x
	decw	x
	ldw	y, x
	ret
00102$:
;	../btowc.c: 39: return c;
	ldw	x, (0x03, sp)
	clrw	y
	tnzw	x
	jrpl	00111$
	decw	y
00111$:
;	../btowc.c: 40: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
