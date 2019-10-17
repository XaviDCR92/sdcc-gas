;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _strcpy
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcpy
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
;	../_strcpy.c: 34: char * strcpy ( char * d, const char * s )
;	-----------------------------------------
;	 function strcpy
;	-----------------------------------------
_strcpy:
;	../_strcpy.c: 37: register char * to = d;
	ldw	y, (0x04, sp)
;	../_strcpy.c: 38: register const char * from = s;
	ldw	x, (0x06, sp)
;	../_strcpy.c: 40: while (*to++ = *from++) ;
00101$:
	ld	a, (x)
	incw	x
	ld	(y), a
	incw	y
	tnz	a
	jrne	00101$
;	../_strcpy.c: 42: return d;
	ldw	x, (0x04, sp)
;	../_strcpy.c: 50: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
