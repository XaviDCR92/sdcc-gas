;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _strcat
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strcat
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
;	../_strcat.c: 31: char * strcat ( char * dst, const char * src )
;	-----------------------------------------
;	 function strcat
;	-----------------------------------------
_strcat:
;	../_strcat.c: 33: char * cp = dst;
	ldw	x, (0x03, sp)
;	../_strcat.c: 35: while( *cp )
00101$:
	ld	a, (x)
	jreq	00111$
;	../_strcat.c: 36: cp++;                   /* find end of dst */
	incw	x
	jra	00101$
;	../_strcat.c: 38: while( *cp++ = *src++ ) ;       /* Copy src to end of dst */
00111$:
	ldw	y, (0x05, sp)
00104$:
	ld	a, (y)
	incw	y
	ld	(x), a
	incw	x
	tnz	a
	jrne	00104$
;	../_strcat.c: 40: return( dst );                  /* return dst */
	ldw	x, (0x03, sp)
;	../_strcat.c: 41: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
