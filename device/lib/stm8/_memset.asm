;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _memset
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memset
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
;	../_memset.c: 41: void *memset (void *s, int c, size_t n)
;	-----------------------------------------
;	 function memset
;	-----------------------------------------
_memset:
	sub	sp, #2
;	../_memset.c: 44: register unsigned char *ret = s;
	ldw	x, (0x05, sp)
;	../_memset.c: 46: while (n--)
	ldw	(0x01, sp), x
	ldw	y, (0x09, sp)
00101$:
	ldw	x, y
	decw	y
	tnzw	x
	jreq	00103$
;	../_memset.c: 48: *(unsigned char *) ret = c;
	ld	a, (0x08, sp)
	ldw	x, (0x01, sp)
	ld	(x), a
;	../_memset.c: 49: ret = ((unsigned char *) ret) + 1;
	ldw	x, (0x01, sp)
	incw	x
	ldw	(0x01, sp), x
	jra	00101$
00103$:
;	../_memset.c: 52: return s;
	ldw	x, (0x05, sp)
;	../_memset.c: 53: }
	addw	sp, #2
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
