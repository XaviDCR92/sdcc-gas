;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module mbstoc16s
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _mbtowc
	.globl ___mbstoc16s
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
;	../mbstoc16s.c: 44: size_t __mbstoc16s(char16_t *restrict c16s, const char *restrict s, size_t n)
;	-----------------------------------------
;	 function __mbstoc16s
;	-----------------------------------------
___mbstoc16s:
	sub	sp, #17
;	../mbstoc16s.c: 46: size_t m = 0;
	clrw	x
	ldw	(0x09, sp), x
;	../mbstoc16s.c: 85: return(m);
00116$:
;	../mbstoc16s.c: 53: l = mbtowc(&codepoint, s, MB_LEN_MAX);
	ldw	x, sp
	addw	x, #5
	push	#0x04
	push	#0x00
	ldw	y, (0x18, sp)
	pushw	y
	pushw	x
	call	_mbtowc
	addw	sp, #6
	ldw	(0x0b, sp), x
;	../mbstoc16s.c: 55: if(l < 0)
	tnz	(0x0b, sp)
	jrpl	00106$
;	../mbstoc16s.c: 56: return(-1);
	clrw	x
	decw	x
	jp	00118$
00106$:
;	../mbstoc16s.c: 59: if(m < n)
	ldw	x, (0x09, sp)
	cpw	x, (0x18, sp)
	clr	a
	rlc	a
	ld	(0x0d, sp), a
;	../mbstoc16s.c: 60: *c16s = 0;
	ldw	y, (0x14, sp)
;	../mbstoc16s.c: 57: else if(!l)
	ldw	x, (0x0b, sp)
	jrne	00107$
;	../mbstoc16s.c: 59: if(m < n)
	tnz	(0x0d, sp)
	jrne	00157$
	jp	00115$
00157$:
;	../mbstoc16s.c: 60: *c16s = 0;
	ldw	x, y
	clr	(0x1, x)
	clr	(x)
;	../mbstoc16s.c: 61: break;
	jp	00115$
00107$:
;	../mbstoc16s.c: 70: m++;
	ldw	x, (0x09, sp)
	incw	x
	ldw	(0x0e, sp), x
;	../mbstoc16s.c: 69: *c16s++ = codepoint;
	ldw	x, y
	incw	x
	incw	x
	ldw	(0x10, sp), x
;	../mbstoc16s.c: 64: if (codepoint <= 0xffff) // Basic multilingual plane
	ldw	x, (0x05, sp)
	jrne	00113$
;	../mbstoc16s.c: 66: if (m >= n)
	ld	a, (0x0d, sp)
	jreq	00115$
;	../mbstoc16s.c: 69: *c16s++ = codepoint;
	ldw	x, (0x07, sp)
	ldw	(0x09, sp), x
	ldw	x, y
	ldw	y, (0x09, sp)
	ldw	(x), y
	ldw	y, (0x10, sp)
	ldw	(0x14, sp), y
;	../mbstoc16s.c: 70: m++;
	ldw	y, (0x0e, sp)
	ldw	(0x09, sp), y
	jra	00114$
00113$:
;	../mbstoc16s.c: 74: if (m + 1 >= n)
	ldw	x, (0x0e, sp)
	cpw	x, (0x18, sp)
	jrnc	00115$
;	../mbstoc16s.c: 77: codepoint -= 0x100000;
	ld	a, (0x08, sp)
	ld	(0x04, sp), a
	ld	a, (0x07, sp)
	ldw	x, (0x05, sp)
	subw	x, #0x0010
	ld	(0x07, sp), a
	ldw	(0x05, sp), x
	ld	a, (0x04, sp)
	ld	(0x08, sp), a
;	../mbstoc16s.c: 78: *c16s++ = ((codepoint >> 10) & 0x3ff) + 0xd800;
	ldw	x, (0x06, sp)
	ldw	(0x03, sp), x
	ld	a, (0x05, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	srl	(0x02, sp)
	rrc	(0x03, sp)
	rrc	(0x04, sp)
	srl	(0x02, sp)
	rrc	(0x03, sp)
	rrc	(0x04, sp)
	ld	a, (0x04, sp)
	ld	xl, a
	ld	a, (0x03, sp)
	and	a, #0x03
	ld	xh, a
	addw	x, #0xd800
	ldw	(y), x
	ldw	y, (0x10, sp)
;	../mbstoc16s.c: 79: *c16s++ = (codepoint & 0x3ff) + 0xdc00;
	ldw	(0x14, sp), y
	ldw	x, (0x07, sp)
	ld	a, xh
	and	a, #0x03
	ld	xh, a
	addw	x, #0xdc00
	ldw	(y), x
	addw	y, #0x0002
	ldw	(0x14, sp), y
;	../mbstoc16s.c: 80: m += 2;
	ldw	x, (0x09, sp)
	incw	x
	incw	x
	ldw	(0x09, sp), x
00114$:
;	../mbstoc16s.c: 82: s += l;
	ldw	x, (0x16, sp)
	addw	x, (0x0b, sp)
	ldw	(0x16, sp), x
	jp	00116$
00115$:
;	../mbstoc16s.c: 85: return(m);
	ldw	x, (0x09, sp)
00118$:
;	../mbstoc16s.c: 86: }
	addw	sp, #17
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
