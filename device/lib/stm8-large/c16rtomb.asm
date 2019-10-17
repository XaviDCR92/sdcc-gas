;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module c16rtomb
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _wctomb
	.globl _c16rtomb
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_c16rtomb_sps_65536_36:
	.ds 3
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
;	../c16rtomb.c: 35: size_t c16rtomb(char *restrict s, char16_t c16, mbstate_t *restrict ps)
;	-----------------------------------------
;	 function c16rtomb
;	-----------------------------------------
_c16rtomb:
	sub	sp, #12
;	../c16rtomb.c: 41: if(!s)
	ldw	x, (0x10, sp)
	jrne	00102$
;	../c16rtomb.c: 42: s = buf;
	ldw	x, sp
	incw	x
	ldw	(0x10, sp), x
00102$:
;	../c16rtomb.c: 44: if(!ps)
	ldw	x, (0x14, sp)
	jrne	00104$
;	../c16rtomb.c: 45: ps = &sps;
	ldw	x, #(_c16rtomb_sps_65536_36 + 0)
	ldw	(0x14, sp), x
00104$:
;	../c16rtomb.c: 49: ps->c[1] = ps->c[2] = 0;
	ldw	y, (0x14, sp)
	ldw	x, y
	incw	x
	ldw	(0x05, sp), x
	ldw	x, y
	incw	x
	incw	x
	ldw	(0x07, sp), x
;	../c16rtomb.c: 47: if (!c16) // 0 always resets conversion state.
	ldw	x, (0x12, sp)
	jrne	00119$
;	../c16rtomb.c: 49: ps->c[1] = ps->c[2] = 0;
	ldw	x, (0x07, sp)
	clr	(x)
	ldw	x, (0x05, sp)
	clr	(x)
;	../c16rtomb.c: 50: codepoint = 0;
	clrw	x
	ldw	(0x0b, sp), x
	ldw	(0x09, sp), x
	jpf	00120$
00119$:
;	../c16rtomb.c: 52: else if(ps->c[1] || ps->c[2]) // We already have the high surrogate. Now get the low surrogate
	ldw	x, (0x05, sp)
	ld	a, (x)
	ld	yl, a
	tnz	a
	jrne	00114$
	ldw	x, (0x07, sp)
	ld	a, (x)
	jreq	00115$
00114$:
;	../c16rtomb.c: 56: if(c16 < 0xdc00 || c16 > 0xdfff)
	ldw	x, (0x12, sp)
	cpw	x, #0xdc00
	jrnc	00169$
	jpf	00121$
00169$:
	ldw	x, (0x12, sp)
	cpw	x, #0xdfff
	jrugt	00121$
;	../c16rtomb.c: 59: high_surrogate = ps->c[1] + (ps->c[2] << 8);
	exg	a, yl
	ld	(0x0a, sp), a
	exg	a, yl
	clr	(0x09, sp)
	ldw	y, (0x07, sp)
	ld	a, (y)
	ld	xh, a
	clr	(0x0c, sp)
	ld	a, (0x0c, sp)
	ld	xl, a
	addw	x, (0x09, sp)
;	../c16rtomb.c: 60: ps->c[1] = ps->c[2] = 0;
	ldw	y, (0x07, sp)
	clr	(y)
	ldw	y, (0x05, sp)
	clr	(y)
;	../c16rtomb.c: 61: codepoint = (high_surrogate << 10) - (0xd800 << 10) + c16 - 0xdc00 + 0x10000;
	clr	a
	rlwa	x
	sllw	x
	sllw	x
	addw	x, (0x12, sp)
	ldw	(0x0b, sp), x
	clr	(0x0a, sp)
	clr	(0x09, sp)
	ldw	x, (0x0b, sp)
	addw	x, #0x2400
	ldw	y, (0x09, sp)
	jrnc	00171$
	incw	y
00171$:
	ldw	(0x0b, sp), x
	ldw	(0x09, sp), y
	jra	00120$
00115$:
;	../c16rtomb.c: 63: else if(c16 < 0xd7ff || c16 >= 0xe000) // Basic multilingual plane.
	ldw	x, (0x12, sp)
	cpw	x, #0xd7ff
	jrc	00110$
	cpw	x, #0xe000
	jrc	00111$
00110$:
;	../c16rtomb.c: 64: codepoint = c16;
	ldw	y, (0x12, sp)
	clrw	x
	ldw	(0x0b, sp), y
	ldw	(0x09, sp), x
	jra	00120$
00111$:
;	../c16rtomb.c: 67: if(c16 > 0xdbff)
	ldw	x, (0x12, sp)
	cpw	x, #0xdbff
	jrugt	00121$
;	../c16rtomb.c: 70: ps->c[1] = c16 & 0xff;
	ld	a, (0x13, sp)
	ldw	x, (0x05, sp)
	ld	(x), a
;	../c16rtomb.c: 71: ps->c[2] = c16 >> 8;
	ld	a, (0x12, sp)
	ld	(0x0c, sp), a
	clr	(0x0b, sp)
	ld	a, (0x0c, sp)
	ldw	x, (0x07, sp)
	ld	(x), a
;	../c16rtomb.c: 72: return(0);
	clrw	x
	jra	00122$
00120$:
;	../c16rtomb.c: 75: return(wctomb(s, codepoint));
	ldw	x, (0x0b, sp)
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	ldw	x, (0x14, sp)
	pushw	x
	callf	_wctomb
	addw	sp, #6
	jra	00122$
;	../c16rtomb.c: 77: eilseq:
00121$:
;	../c16rtomb.c: 78: errno = EILSEQ;
	ldw	x, #0x0054
	ldw	_errno+0, x
;	../c16rtomb.c: 79: return(-1);
	clrw	x
	decw	x
00122$:
;	../c16rtomb.c: 80: }
	addw	sp, #12
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
