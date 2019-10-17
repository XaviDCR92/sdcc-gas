;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _strncpy
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strncpy
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
;	../_strncpy.c: 33: char *strncpy ( char * d, const char * s, size_t n )
;	-----------------------------------------
;	 function strncpy
;	-----------------------------------------
_strncpy:
	sub	sp, #6
;	../_strncpy.c: 35: register char * d1 =  d;
	ldw	y, (0x09, sp)
	ldw	(0x01, sp), y
;	../_strncpy.c: 37: while ( n && *s )
	ldw	y, (0x0d, sp)
	ldw	(0x05, sp), y
	ldw	y, (0x0b, sp)
	ldw	(0x03, sp), y
	ldw	x, (0x01, sp)
00102$:
	ldw	y, (0x05, sp)
	jreq	00114$
	ldw	y, (0x03, sp)
	ld	a, (y)
	jreq	00114$
;	../_strncpy.c: 39: n-- ;
	ldw	y, (0x05, sp)
	decw	y
	ldw	(0x05, sp), y
;	../_strncpy.c: 40: *d++ = *s++ ;
	ldw	y, (0x03, sp)
	incw	y
	ldw	(0x03, sp), y
	ld	(x), a
	incw	x
	jra	00102$
;	../_strncpy.c: 42: while ( n-- )
00114$:
00105$:
	ldw	y, (0x05, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x05, sp)
	decw	y
	ldw	(0x05, sp), y
	ldw	y, (0x03, sp)
	jreq	00107$
;	../_strncpy.c: 44: *d++ = '\0' ;
	clr	(x)
	incw	x
	jra	00105$
00107$:
;	../_strncpy.c: 46: return d1;
	ldw	x, (0x01, sp)
;	../_strncpy.c: 47: }
	addw	sp, #6
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
