;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module toupper
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _toupper
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
;	../toupper.c: 33: int toupper (int c)
;	-----------------------------------------
;	 function toupper
;	-----------------------------------------
_toupper:
;	../toupper.c: 35: return (islower (c) ? c + ('A' - 'a') : c);
	ldw	x, (0x04, sp)
;	./../../include/ctype.h: 71: return ((unsigned char)c >= 'a' && (unsigned char)c <= 'z');
	ld	a, xl
	cp	a, #0x61
	jrc	00104$
	cp	a, #0x7a
	jrugt	00104$
;	../toupper.c: 35: return (islower (c) ? c + ('A' - 'a') : c);
	addw	x, #0xffe0
00104$:
;	../toupper.c: 36: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
