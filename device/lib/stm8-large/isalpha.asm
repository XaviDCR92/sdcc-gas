;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module isalpha
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _isalpha
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
;	../isalpha.c: 37: int isalpha (int c)
;	-----------------------------------------
;	 function isalpha
;	-----------------------------------------
_isalpha:
;	../isalpha.c: 39: return (isupper (c) || islower (c));
	ldw	x, (0x04, sp)
;	./../../include/ctype.h: 80: return ((unsigned char)c >= 'A' && (unsigned char)c <= 'Z');
	ld	a, xl
	cp	a, #0x41
	jrc	00110$
	cp	a, #0x5a
	jrule	00106$
00110$:
;	./../../include/ctype.h: 71: return ((unsigned char)c >= 'a' && (unsigned char)c <= 'z');
	cp	a, #0x61
	jrc	00113$
	cp	a, #0x7a
	jrule	00106$
00113$:
;	../isalpha.c: 39: return (isupper (c) || islower (c));
	clr	a
	.byte 0xc5
00106$:
	ld	a, #0x01
00107$:
	clrw	x
	ld	xl, a
;	../isalpha.c: 40: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
