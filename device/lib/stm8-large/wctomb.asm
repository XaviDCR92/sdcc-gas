;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module wctomb
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _wctomb
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
;	../wctomb.c: 31: int wctomb(char *s, wchar_t wc)
;	-----------------------------------------
;	 function wctomb
;	-----------------------------------------
_wctomb:
	sub	sp, #12
;	../wctomb.c: 33: if(!s)
;	../wctomb.c: 34: return(0);
	ldw	x, (0x10, sp)
	jrne	00102$
	jpf	00119$
00102$:
;	../wctomb.c: 38: s[0] = wc;
	ldw	y, (0x10, sp)
	ldw	(0x01, sp), y
	ld	a, (0x15, sp)
;	../wctomb.c: 36: if(wc < 0x80)
	ldw	x, (0x14, sp)
	cpw	x, #0x0080
	push	a
	ld	a, (0x14, sp)
	sbc	a, #0x00
	ld	a, (0x13, sp)
	sbc	a, #0x00
	pop	a
	jrnc	00117$
;	../wctomb.c: 38: s[0] = wc;
	ldw	x, (0x01, sp)
	ld	(x), a
;	../wctomb.c: 39: return(1);
	clrw	x
	incw	x
	jpf	00119$
00117$:
;	../wctomb.c: 43: s[0] = (wc >> 6) & 0x1f | 0xc0;
	ldw	x, (0x14, sp)
	push	a
	ld	a, #0x40
	div	x, a
	pop	a
;	../wctomb.c: 44: s[1] = (wc >> 0) & 0x3f | 0x80;
	ldw	y, (0x01, sp)
	incw	y
	ldw	(0x03, sp), y
	and	a, #0x3f
;	../wctomb.c: 43: s[0] = (wc >> 6) & 0x1f | 0xc0;
	exg	a, xl
	ld	(0x08, sp), a
	exg	a, xl
;	../wctomb.c: 44: s[1] = (wc >> 0) & 0x3f | 0x80;
	or	a, #0x80
	ld	(0x05, sp), a
;	../wctomb.c: 41: else if(wc < 0x800)
	ldw	x, (0x14, sp)
	cpw	x, #0x0800
	ld	a, (0x13, sp)
	sbc	a, #0x00
	ld	a, (0x12, sp)
	sbc	a, #0x00
	jrnc	00114$
;	../wctomb.c: 43: s[0] = (wc >> 6) & 0x1f | 0xc0;
	ld	a, (0x08, sp)
	and	a, #0x1f
	or	a, #0xc0
	ldw	x, (0x01, sp)
	ld	(x), a
;	../wctomb.c: 44: s[1] = (wc >> 0) & 0x3f | 0x80;
	ldw	x, (0x03, sp)
	ld	a, (0x05, sp)
	ld	(x), a
;	../wctomb.c: 45: return(2);
	ldw	x, #0x0002
	jpf	00119$
00114$:
;	../wctomb.c: 47: else if(wc >= 0xd800 && wc < 0xe000) // Unpaired surrogate
	ldw	x, (0x14, sp)
	cpw	x, #0xd800
	ld	a, (0x13, sp)
	sbc	a, #0x00
	ld	a, (0x12, sp)
	sbc	a, #0x00
	jrc	00110$
	ldw	x, (0x14, sp)
	cpw	x, #0xe000
	ld	a, (0x13, sp)
	sbc	a, #0x00
	ld	a, (0x12, sp)
	sbc	a, #0x00
	jrnc	00110$
;	../wctomb.c: 48: return(-1);
	clrw	x
	decw	x
	jpf	00119$
00110$:
;	../wctomb.c: 51: s[0] = (wc >> 12) & 0x0f | 0xe0;
	ldw	y, (0x12, sp)
	ldw	(0x09, sp), y
	ldw	x, (0x14, sp)
	ld	a, #0x0c
00161$:
	srl	(0x09, sp)
	rrc	(0x0a, sp)
	rrcw	x
	dec	a
	jrne	00161$
	ldw	(0x0b, sp), x
;	../wctomb.c: 53: s[2] = (wc >> 0) & 0x3f  | 0x80;
	ldw	x, (0x01, sp)
	incw	x
	incw	x
	ldw	(0x06, sp), x
;	../wctomb.c: 51: s[0] = (wc >> 12) & 0x0f | 0xe0;
	ld	a, (0x0c, sp)
	ld	yl, a
;	../wctomb.c: 52: s[1] = (wc >> 6) & 0x3f  | 0x80;
	ld	a, (0x08, sp)
	and	a, #0x3f
	or	a, #0x80
	ld	(0x08, sp), a
;	../wctomb.c: 49: else if(wc < 0x10000)
	ldw	x, (0x12, sp)
	cpw	x, #0x0001
	jrnc	00107$
;	../wctomb.c: 51: s[0] = (wc >> 12) & 0x0f | 0xe0;
	ld	a, yl
	and	a, #0x0f
	or	a, #0xe0
	ldw	x, (0x01, sp)
	ld	(x), a
;	../wctomb.c: 52: s[1] = (wc >> 6) & 0x3f  | 0x80;
	ldw	x, (0x03, sp)
	ld	a, (0x08, sp)
	ld	(x), a
;	../wctomb.c: 53: s[2] = (wc >> 0) & 0x3f  | 0x80;
	ldw	x, (0x06, sp)
	ld	a, (0x05, sp)
	ld	(x), a
;	../wctomb.c: 54: return(3);
	ldw	x, #0x0003
	jra	00119$
00107$:
;	../wctomb.c: 56: else if(wc < 0x110000)
;	../wctomb.c: 58: s[0] = (wc >> 18) & 0x07 | 0xf0;
	ldw	x, (0x12, sp)
	cpw	x, #0x0011
	jrnc	00104$
	ldw	(0x0b, sp), x
	clr	(0x0a, sp)
	clr	(0x09, sp)
	srl	(0x0b, sp)
	rrc	(0x0c, sp)
	srl	(0x0b, sp)
	rrc	(0x0c, sp)
	ld	a, (0x0c, sp)
	and	a, #0x07
	or	a, #0xf0
	ldw	x, (0x01, sp)
	ld	(x), a
;	../wctomb.c: 59: s[1] = (wc >> 12) & 0x3f | 0x80;
	ld	a, yl
	and	a, #0x3f
	or	a, #0x80
	ldw	x, (0x03, sp)
	ld	(x), a
;	../wctomb.c: 60: s[2] = (wc >> 6) & 0x3f  | 0x80;
	ldw	x, (0x06, sp)
	ld	a, (0x08, sp)
	ld	(x), a
;	../wctomb.c: 61: s[3] = (wc >> 0) & 0x3f  | 0x80;
	ldw	x, (0x01, sp)
	ld	a, (0x05, sp)
	ld	(0x0003, x), a
;	../wctomb.c: 62: return(4);
	ldw	x, #0x0004
	jra	00119$
00104$:
;	../wctomb.c: 65: return(-1);
	clrw	x
	decw	x
00119$:
;	../wctomb.c: 66: }
	addw	sp, #12
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
