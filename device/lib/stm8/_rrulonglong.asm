;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _rrulonglong
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __rrulonglong
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
;	../_rrulonglong.c: 38: unsigned long long _rrulonglong(unsigned long long l, char s)
;	-----------------------------------------
;	 function _rrulonglong
;	-----------------------------------------
__rrulonglong:
	sub	sp, #16
;	../_rrulonglong.c: 40: uint32_t *const top = (uint32_t *)((char *)(&l) + 0);
	ldw	y, sp
	addw	y, #19
	ldw	x, y
	ldw	(0x05, sp), x
;	../_rrulonglong.c: 41: uint32_t *const middle = (uint16_t *)((char *)(&l) + 2);
	ldw	x, y
	incw	x
	incw	x
	ldw	(0x07, sp), x
;	../_rrulonglong.c: 42: uint32_t *const bottom = (uint32_t *)((char *)(&l) + 4);
	ldw	x, y
	addw	x, #0x0004
	ldw	(0x09, sp), x
;	../_rrulonglong.c: 43: uint16_t *const b = (uint16_t *)(&l);
	ldw	(0x0b, sp), y
;	../_rrulonglong.c: 53: (*bottom) >>= s;
00103$:
;	../_rrulonglong.c: 45: for(;s >= 16; s -= 16)
	ld	a, (0x1d, sp)
	cp	a, #0x10
	jrc	00101$
;	../_rrulonglong.c: 47: b[3] = b[2];
	ldw	x, (0x0b, sp)
	addw	x, #0x0006
	ldw	y, (0x0b, sp)
	addw	y, #0x0004
	ldw	(0x0d, sp), y
	ldw	y, (y)
	ldw	(x), y
;	../_rrulonglong.c: 48: b[2] = b[1];
	ldw	x, (0x0b, sp)
	incw	x
	incw	x
	ldw	(0x0f, sp), x
	ldw	x, (x)
	ldw	y, (0x0d, sp)
	ldw	(y), x
;	../_rrulonglong.c: 49: b[1] = b[0];
	ldw	x, (0x0b, sp)
	ldw	x, (x)
	ldw	y, (0x0f, sp)
	ldw	(y), x
;	../_rrulonglong.c: 50: b[0] = 0x000000;
	ldw	x, (0x0b, sp)
	clr	(0x1, x)
	clr	(x)
;	../_rrulonglong.c: 45: for(;s >= 16; s -= 16)
	ld	a, (0x1d, sp)
	sub	a, #0x10
	ld	(0x1d, sp), a
	jra	00103$
00101$:
;	../_rrulonglong.c: 53: (*bottom) >>= s;
	ldw	x, (0x09, sp)
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	x, (x)
	ld	a, (0x1d, sp)
	jreq	00119$
00118$:
	srlw	x
	rrcw	y
	dec	a
	jrne	00118$
00119$:
	ldw	(0x0f, sp), y
	ldw	(0x0d, sp), x
	ldw	x, (0x09, sp)
	ldw	y, (0x0f, sp)
	ldw	(0x2, x), y
	ldw	y, (0x0d, sp)
	ldw	(x), y
;	../_rrulonglong.c: 54: (*middle) |= (((*middle & 0xffff0000ul) >> s) & 0x0000fffful);
	ldw	x, (0x07, sp)
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	(0x03, sp), y
	ldw	x, (x)
	ldw	(0x01, sp), x
	clrw	x
	ldw	y, (0x01, sp)
	ld	a, (0x1d, sp)
	jreq	00121$
00120$:
	srlw	y
	rrcw	x
	dec	a
	jrne	00120$
00121$:
	ldw	(0x0b, sp), x
	clr	(0x0a, sp)
	clr	(0x09, sp)
	ld	a, (0x04, sp)
	or	a, (0x0c, sp)
	ld	(0x10, sp), a
	ld	a, (0x03, sp)
	or	a, (0x0b, sp)
	ld	(0x0f, sp), a
	ld	a, (0x02, sp)
	or	a, (0x0a, sp)
	ld	(0x0e, sp), a
	ld	a, (0x01, sp)
	or	a, (0x09, sp)
	ld	(0x0d, sp), a
	ldw	x, (0x07, sp)
	ldw	y, (0x0f, sp)
	ldw	(0x2, x), y
	ldw	y, (0x0d, sp)
	ldw	(x), y
;	../_rrulonglong.c: 55: (*top) >>= s;
	ldw	x, (0x05, sp)
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	x, (x)
	ld	a, (0x1d, sp)
	jreq	00123$
00122$:
	srlw	x
	rrcw	y
	dec	a
	jrne	00122$
00123$:
	ldw	(0x0f, sp), y
	ldw	(0x0d, sp), x
	ldw	x, (0x05, sp)
	ldw	y, (0x0f, sp)
	ldw	(0x2, x), y
	ldw	y, (0x0d, sp)
	ldw	(x), y
;	../_rrulonglong.c: 57: return(l);
	ldw	x, (0x13, sp)
	ldw	y, (0x1b, sp)
	ldw	(#6, x), y
	ldw	y, (0x19, sp)
	ldw	(#4, x), y
	ldw	y, (0x17, sp)
	ldw	(#2, x), y
	ldw	y, (0x15, sp)
	ldw	(x), y
;	../_rrulonglong.c: 58: }
	addw	sp, #16
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
