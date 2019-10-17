;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _memchr
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memchr
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
;	../_memchr.c: 31: void *memchr(const void *s, int c, size_t n)
;	-----------------------------------------
;	 function memchr
;	-----------------------------------------
_memchr:
	sub	sp, #5
;	../_memchr.c: 33: unsigned char *p = (unsigned char *)s;
	ldw	x, (0x09, sp)
;	../_memchr.c: 34: unsigned char *end = p + n;
	ldw	(0x01, sp), x
	addw	x, (0x0d, sp)
	ldw	(0x03, sp), x
;	../_memchr.c: 38: return(0);
	ldw	x, (0x01, sp)
00105$:
;	../_memchr.c: 35: for(; p != end; p++)
	cpw	x, (0x03, sp)
	jreq	00103$
;	../_memchr.c: 36: if(*p == (unsigned char)c)
	ld	a, (x)
	ld	(0x05, sp), a
	ld	a, (0x0c, sp)
	cp	a, (0x05, sp)
	jrne	00106$
;	../_memchr.c: 37: return((void *)p);
	ldw	x, (0x01, sp)
	jra	00107$
00106$:
;	../_memchr.c: 35: for(; p != end; p++)
	incw	x
	ldw	(0x01, sp), x
	jra	00105$
00103$:
;	../_memchr.c: 38: return(0);
	clrw	x
00107$:
;	../_memchr.c: 39: }
	addw	sp, #5
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
