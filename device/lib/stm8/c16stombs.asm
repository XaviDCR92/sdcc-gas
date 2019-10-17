;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module c16stombs
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___memcpy
	.globl _wctomb
	.globl ___c16stombs
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
;	../c16stombs.c: 44: size_t __c16stombs(char *restrict s, const char16_t *restrict c16s, size_t n)
;	-----------------------------------------
;	 function __c16stombs
;	-----------------------------------------
___c16stombs:
	sub	sp, #18
;	../c16stombs.c: 46: size_t m = 0;
	clrw	x
	ldw	(0x09, sp), x
;	../c16stombs.c: 87: return(m);
00119$:
;	../c16stombs.c: 54: if(c16s[0] < 0xd800 || c16s[0] >= 0xe000) // Basic multilingual plane
	ldw	y, (0x17, sp)
	ldw	(0x0b, sp), y
	ldw	x, y
	ldw	x, (x)
	ldw	(0x03, sp), x
;	../c16stombs.c: 57: c16s++;
	ldw	x, (0x0b, sp)
	incw	x
	incw	x
	ldw	(0x0d, sp), x
;	../c16stombs.c: 56: codepoint = c16s[0];
	ldw	y, (0x03, sp)
	ldw	(0x11, sp), y
	clr	(0x10, sp)
	clr	(0x0f, sp)
;	../c16stombs.c: 54: if(c16s[0] < 0xd800 || c16s[0] >= 0xe000) // Basic multilingual plane
	ldw	x, (0x03, sp)
	cpw	x, #0xd800
	jrc	00106$
	cpw	x, #0xe000
	jrc	00107$
00106$:
;	../c16stombs.c: 56: codepoint = c16s[0];
;	../c16stombs.c: 57: c16s++;
	ldw	x, (0x0d, sp)
	ldw	(0x17, sp), x
	jra	00108$
00107$:
;	../c16stombs.c: 59: else if(c16s[0] > 0xdbff || c16s[1] < 0xdc00 || c16s[1] > 0xdfff) // Unpaired surrogate
	ldw	x, (0x03, sp)
	cpw	x, #0xdbff
	jrugt	00101$
	ldw	x, (0x0d, sp)
	ldw	x, (x)
	cpw	x, #0xdc00
	jrc	00101$
	cpw	x, #0xdfff
	jrule	00102$
00101$:
;	../c16stombs.c: 60: return(-1);
	clrw	x
	decw	x
	jp	00121$
00102$:
;	../c16stombs.c: 63: codepoint = ((unsigned long)(c16s[0]) << 10) -(0xd800ul << 10) + (unsigned long)(c16s[1]) - 0xdc00ul + 0x10000ul;
	ld	a, #0x0a
00168$:
	sll	(0x12, sp)
	rlc	(0x11, sp)
	rlc	(0x10, sp)
	rlc	(0x0f, sp)
	dec	a
	jrne	00168$
	ldw	(0x03, sp), x
	clrw	x
	ldw	y, (0x03, sp)
	addw	y, (0x11, sp)
	ld	a, xl
	adc	a, (0x10, sp)
	push	a
	ld	a, xh
	adc	a, (0x10, sp)
	ld	xh, a
	pop	a
	addw	y, #0x2400
	adc	a, #0xa0
	rlwa	x
	adc	a, #0xfc
	ld	xh, a
	ldw	(0x11, sp), y
	ldw	(0x0f, sp), x
;	../c16stombs.c: 64: c16s += 2;
	ldw	x, (0x0b, sp)
	addw	x, #0x0004
	ldw	(0x17, sp), x
00108$:
;	../c16stombs.c: 67: if(!codepoint)
	ldw	x, (0x11, sp)
	jrne	00113$
	ldw	x, (0x0f, sp)
	jrne	00113$
;	../c16stombs.c: 69: if(m < n)
	ldw	x, (0x09, sp)
	cpw	x, (0x19, sp)
	jrnc	00118$
;	../c16stombs.c: 70: *s = 0;
	ldw	x, (0x15, sp)
	clr	(x)
;	../c16stombs.c: 71: break;
	jra	00118$
00113$:
;	../c16stombs.c: 74: l = wctomb(b, codepoint);
	ldw	x, sp
	addw	x, #5
	ldw	(0x0d, sp), x
	ldw	y, (0x11, sp)
	pushw	y
	ldw	y, (0x11, sp)
	pushw	y
	pushw	x
	call	_wctomb
	addw	sp, #6
	ldw	(0x0f, sp), x
;	../c16stombs.c: 76: if(l < 0)
	tnz	(0x0f, sp)
	jrpl	00115$
;	../c16stombs.c: 77: return(-1);
	clrw	x
	decw	x
	jra	00121$
00115$:
;	../c16stombs.c: 79: if(m + l > n)
	ldw	x, (0x0f, sp)
	addw	x, (0x09, sp)
	ldw	(0x11, sp), x
	cpw	x, (0x19, sp)
	jrugt	00118$
;	../c16stombs.c: 82: memcpy(s, b, l);
	ldw	y, (0x0d, sp)
	ldw	x, (0x15, sp)
	ld	a, (0x10, sp)
	push	a
	ld	a, (0x10, sp)
	push	a
	pushw	y
	pushw	x
	call	___memcpy
	addw	sp, #6
;	../c16stombs.c: 83: s += l;
	ldw	x, (0x15, sp)
	addw	x, (0x0f, sp)
	ldw	(0x15, sp), x
;	../c16stombs.c: 84: m += l;
	ldw	x, (0x11, sp)
	ldw	(0x09, sp), x
	jp	00119$
00118$:
;	../c16stombs.c: 87: return(m);
	ldw	x, (0x09, sp)
00121$:
;	../c16stombs.c: 88: }
	addw	sp, #18
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
