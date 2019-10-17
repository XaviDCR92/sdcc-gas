;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _strstr
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strstr
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
;	../_strstr.c: 31: char *strstr ( const char *str1, const char *str2 )
;	-----------------------------------------
;	 function strstr
;	-----------------------------------------
_strstr:
	sub	sp, #13
;	../_strstr.c: 33: const char *cp = str1;
	ldw	y, (0x11, sp)
	ldw	(0x01, sp), y
;	../_strstr.c: 37: if (!*str2)
	ldw	y, (0x13, sp)
	ldw	(0x03, sp), y
	ldw	x, y
	ld	a, (x)
	ld	(0x0d, sp), a
	jrne	00122$
;	../_strstr.c: 38: return ((char*)str1);
	ldw	x, (0x01, sp)
	jra	00113$
;	../_strstr.c: 40: while (*cp)
00122$:
	ldw	y, (0x01, sp)
	ldw	(0x08, sp), y
00110$:
	ldw	x, (0x08, sp)
	ld	a, (x)
	jreq	00112$
;	../_strstr.c: 43: s2 = str2;
	ldw	x, (0x03, sp)
;	../_strstr.c: 45: while (*s1 && *s2 && !(*s1-*s2))
	ldw	y, (0x08, sp)
	ldw	(0x0a, sp), y
	ldw	(0x0c, sp), x
00105$:
	ldw	x, (0x0a, sp)
	ld	a, (x)
	ld	(0x07, sp), a
	ldw	x, (0x0c, sp)
	ld	a, (x)
	ld	(0x05, sp), a
	tnz	(0x07, sp)
	jreq	00107$
	tnz	(0x05, sp)
	jreq	00107$
	clrw	x
	ld	a, (0x07, sp)
	ld	xl, a
	ld	a, (0x05, sp)
	ld	(0x07, sp), a
	clr	(0x06, sp)
	subw	x, (0x06, sp)
	tnzw	x
	jrne	00107$
;	../_strstr.c: 46: s1++, s2++;
	ldw	x, (0x0a, sp)
	incw	x
	ldw	(0x0a, sp), x
	ldw	x, (0x0c, sp)
	incw	x
	ldw	(0x0c, sp), x
	jra	00105$
00107$:
;	../_strstr.c: 48: if (!*s2)
	tnz	(0x05, sp)
	jrne	00109$
;	../_strstr.c: 49: return ((char*)cp);
	ldw	x, (0x01, sp)
	jra	00113$
00109$:
;	../_strstr.c: 51: cp++;
	ldw	x, (0x08, sp)
	incw	x
	ldw	(0x08, sp), x
	ldw	(0x01, sp), x
	jra	00110$
00112$:
;	../_strstr.c: 54: return (NULL) ;
	clrw	x
00113$:
;	../_strstr.c: 55: }
	addw	sp, #13
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
