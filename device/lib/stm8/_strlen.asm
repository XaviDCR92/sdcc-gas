;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _strlen
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strlen
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
;	../_strlen.c: 35: size_t strlen ( const char * str )
;	-----------------------------------------
;	 function strlen
;	-----------------------------------------
_strlen:
;	../_strlen.c: 39: while (*str++)
	clrw	x
	ldw	y, (0x03, sp)
00101$:
	ld	a, (y)
	incw	y
	tnz	a
	jrne	00117$
	ret
00117$:
;	../_strlen.c: 40: i++ ;
	incw	x
	jra	00101$
;	../_strlen.c: 42: return i;
;	../_strlen.c: 43: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
