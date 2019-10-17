;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _strchr
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strchr
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
;	../_strchr.c: 36: char * strchr ( const char * string, int ch )
;	-----------------------------------------
;	 function strchr
;	-----------------------------------------
_strchr:
	push	a
;	../_strchr.c: 39: while (*string && *string != ch)
	ldw	x, (0x04, sp)
00102$:
	ld	a, (x)
	ld	(0x01, sp), a
	clrw	y
	ld	a, (0x01, sp)
	ld	yl, a
	exgw	x, y
	cpw	x, (0x06, sp)
	exgw	x, y
	jrne	00131$
	ld	a, #0x01
	.byte 0x21
00131$:
	clr	a
00132$:
	tnz	(0x01, sp)
	jreq	00104$
	tnz	a
	jrne	00104$
;	../_strchr.c: 40: string++;
	incw	x
	jra	00102$
00104$:
;	../_strchr.c: 42: if (*string == ch)
	tnz	a
;	../_strchr.c: 43: return((char *)string);
	jrne	00107$
;	../_strchr.c: 44: return ( NULL );
	clrw	x
00107$:
;	../_strchr.c: 45: }
	pop	a
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
