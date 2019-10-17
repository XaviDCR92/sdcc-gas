;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _strrchr
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strrchr
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
;	../_strrchr.c: 34: char * strrchr ( const char * string, int ch )
;	-----------------------------------------
;	 function strrchr
;	-----------------------------------------
_strrchr:
	sub	sp, #2
;	../_strrchr.c: 37: const char * start = string;
	ldw	y, (0x05, sp)
;	../_strrchr.c: 39: while (*string++)                       /* find end of string */
	ldw	x, y
00101$:
	ld	a, (x)
	incw	x
	tnz	a
	jrne	00101$
;	../_strrchr.c: 42: while (--string != start && *string != ch)
	ldw	(0x01, sp), x
00105$:
	ldw	x, (0x01, sp)
	decw	x
	ldw	(0x01, sp), x
	ld	a, (x)
	clrw	x
	ld	xl, a
	cpw	x, (0x07, sp)
	jrne	00140$
	ld	a, #0x01
	.byte 0x21
00140$:
	clr	a
00141$:
	ldw	x, y
	cpw	x, (0x01, sp)
	jreq	00107$
	tnz	a
	jreq	00105$
00107$:
;	../_strrchr.c: 45: if (*string == ch)                      /* char found ? */
	tnz	a
	jreq	00109$
;	../_strrchr.c: 46: return( (char *)string );
	ldw	x, (0x01, sp)
;	../_strrchr.c: 48: return (NULL) ;
	.byte 0x21
00109$:
	clrw	x
00110$:
;	../_strrchr.c: 49: }
	addw	sp, #2
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
