;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _strspn
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strchr
	.globl _strspn
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
;	../_strspn.c: 31: size_t strspn ( const char * string, const char * control )
;	-----------------------------------------
;	 function strspn
;	-----------------------------------------
_strspn:
	sub	sp, #2
;	../_strspn.c: 36: while (ch = *string) {
	clrw	x
	ldw	(0x01, sp), x
	ldw	y, (0x05, sp)
00104$:
	ld	a, (y)
	ld	xl, a
	tnz	a
	jreq	00106$
;	../_strspn.c: 37: if ( strchr(control,ch) )
	clr	a
	ld	xh, a
	pushw	y
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	call	_strchr
	addw	sp, #4
	popw	y
	tnzw	x
	jreq	00106$
;	../_strspn.c: 38: count++ ;
	ldw	x, (0x01, sp)
	incw	x
	ldw	(0x01, sp), x
;	../_strspn.c: 41: string++ ;
	incw	y
	jra	00104$
00106$:
;	../_strspn.c: 44: return count ;
	ldw	x, (0x01, sp)
;	../_strspn.c: 45: }
	addw	sp, #2
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
