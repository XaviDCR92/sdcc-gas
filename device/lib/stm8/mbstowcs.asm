;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module mbstowcs
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _mbtowc
	.globl _mbstowcs
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
;	../mbstowcs.c: 33: size_t mbstowcs(wchar_t *restrict pwcs, const char *restrict s, size_t n)
;	-----------------------------------------
;	 function mbstowcs
;	-----------------------------------------
_mbstowcs:
	sub	sp, #8
;	../mbstowcs.c: 35: size_t m = 0;
	clrw	x
	ldw	(0x01, sp), x
;	../mbstowcs.c: 36: while(n--)
	ldw	y, (0x0b, sp)
	ldw	(0x03, sp), y
	clrw	x
	ldw	(0x05, sp), x
	ldw	y, (0x0f, sp)
	ldw	(0x07, sp), y
00105$:
	ldw	x, (0x07, sp)
	ldw	y, (0x07, sp)
	decw	y
	ldw	(0x07, sp), y
	tnzw	x
	jreq	00107$
;	../mbstowcs.c: 38: int b = mbtowc(pwcs++, s, MB_LEN_MAX);
	ldw	y, (0x03, sp)
	ldw	x, (0x03, sp)
	addw	x, #0x0004
	ldw	(0x03, sp), x
	push	#0x04
	push	#0x00
	ldw	x, (0x0f, sp)
	pushw	x
	pushw	y
	call	_mbtowc
	addw	sp, #6
;	../mbstowcs.c: 39: if(!b)
	tnzw	x
	jreq	00107$
;	../mbstowcs.c: 41: if(b < 0)
	tnzw	x
	jrpl	00104$
;	../mbstowcs.c: 42: return(-1);
	clrw	x
	decw	x
	jra	00108$
00104$:
;	../mbstowcs.c: 43: s += b;
	addw	x, (0x0d, sp)
	ldw	(0x0d, sp), x
;	../mbstowcs.c: 44: m++;
	ldw	x, (0x05, sp)
	incw	x
	ldw	(0x05, sp), x
	ldw	(0x01, sp), x
	jra	00105$
00107$:
;	../mbstowcs.c: 47: return(m);
	ldw	x, (0x01, sp)
00108$:
;	../mbstowcs.c: 48: }
	addw	sp, #8
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
