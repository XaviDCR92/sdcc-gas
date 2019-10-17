;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _strpbrk
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strchr
	.globl _strpbrk
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
;	../_strpbrk.c: 31: char * strpbrk ( const char * string, const char * control )
;	-----------------------------------------
;	 function strpbrk
;	-----------------------------------------
_strpbrk:
	sub	sp, #4
;	../_strpbrk.c: 33: char *ret = NULL;
	clrw	x
	ldw	(0x01, sp), x
;	../_strpbrk.c: 36: while (ch = *control) {
	ldw	y, (0x0a, sp)
	ldw	(0x03, sp), y
00105$:
	ldw	x, (0x03, sp)
	ld	a, (x)
	ld	xl, a
	tnz	a
	jreq	00107$
;	../_strpbrk.c: 37: char * p = strchr(string, ch);
	clr	a
	ld	xh, a
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	callf	_strchr
	addw	sp, #4
;	../_strpbrk.c: 38: if (p != NULL && (ret == NULL || p < ret)) {
	tnzw	x
	jreq	00102$
	ldw	y, (0x01, sp)
	jreq	00101$
	cpw	x, (0x01, sp)
	jrnc	00102$
00101$:
;	../_strpbrk.c: 39: ret = p;
	ldw	(0x01, sp), x
00102$:
;	../_strpbrk.c: 41: control++;
	ldw	x, (0x03, sp)
	incw	x
	ldw	(0x03, sp), x
	jra	00105$
00107$:
;	../_strpbrk.c: 44: return (ret);
	ldw	x, (0x01, sp)
;	../_strpbrk.c: 45: }
	addw	sp, #4
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
