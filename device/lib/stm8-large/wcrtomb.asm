;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module wcrtomb
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _wctomb
	.globl _wcrtomb
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
;	../wcrtomb.c: 34: size_t wcrtomb(char *restrict s, wchar_t wc, mbstate_t *restrict ps)
;	-----------------------------------------
;	 function wcrtomb
;	-----------------------------------------
_wcrtomb:
;	../wcrtomb.c: 40: ret = wctomb(s, wc);
	ldw	x, (0x08, sp)
	pushw	x
	ldw	x, (0x08, sp)
	pushw	x
	ldw	x, (0x08, sp)
	pushw	x
	callf	_wctomb
	addw	sp, #6
;	../wcrtomb.c: 42: if(ret == (size_t)(-1))
	cpw	x, #0xffff
	jrne	00102$
;	../wcrtomb.c: 43: errno = EILSEQ;
	mov	_errno+1, #0x54
	clr	_errno+0
00102$:
;	../wcrtomb.c: 45: return(ret);
;	../wcrtomb.c: 46: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
