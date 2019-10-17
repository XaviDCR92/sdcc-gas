;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _divulonglong
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __divulonglong
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
;	../_divulonglong.c: 39: _divulonglong (unsigned long long x, unsigned long long y)
;	-----------------------------------------
;	 function _divulonglong
;	-----------------------------------------
__divulonglong:
	sub	sp, #17
;	../_divulonglong.c: 41: unsigned long long reste = 0L;
	clrw	x
	ldw	(0x10, sp), x
	ldw	(0x0e, sp), x
	ldw	(0x0c, sp), x
	ldw	(0x0a, sp), x
;	../_divulonglong.c: 42: unsigned char count = 64;
	ld	a, #0x40
	ld	(0x01, sp), a
;	../_divulonglong.c: 45: do
00105$:
;	../_divulonglong.c: 48: c = MSB_SET(x);
	ld	a, (0x17, sp)
	sll	a
	clr	a
	rlc	a
;	../_divulonglong.c: 49: x <<= 1;
	sll	(0x1e, sp)
	rlc	(0x1d, sp)
	rlc	(0x1c, sp)
	rlc	(0x1b, sp)
	rlc	(0x1a, sp)
	rlc	(0x19, sp)
	rlc	(0x18, sp)
	rlc	(0x17, sp)
;	../_divulonglong.c: 50: reste <<= 1;
	sll	(0x11, sp)
	rlc	(0x10, sp)
	rlc	(0x0f, sp)
	rlc	(0x0e, sp)
	rlc	(0x0d, sp)
	rlc	(0x0c, sp)
	rlc	(0x0b, sp)
	rlc	(0x0a, sp)
;	../_divulonglong.c: 51: if (c)
	tnz	a
	jreq	00102$
;	../_divulonglong.c: 52: reste |= 1L;
	ld	a, (0x11, sp)
	or	a, #0x01
	ld	(0x09, sp), a
	ld	a, (0x10, sp)
	ld	(0x08, sp), a
	ld	a, (0x0f, sp)
	ld	(0x07, sp), a
	ld	a, (0x0e, sp)
	exg	a, xl
	ld	a, (0x0d, sp)
	exg	a, xl
	rlwa	x
	ld	a, (0x0c, sp)
	rrwa	x
	exg	a, yl
	ld	a, (0x0b, sp)
	exg	a, yl
	rlwa	y
	ld	a, (0x0a, sp)
	rrwa	y
	ld	(0x0e, sp), a
	ldw	(0x0c, sp), x
	ldw	(0x0a, sp), y
	ldw	y, (0x08, sp)
	ldw	(0x10, sp), y
	ld	a, (0x07, sp)
	ld	(0x0f, sp), a
00102$:
;	../_divulonglong.c: 54: if (reste >= y)
	ldw	x, (0x10, sp)
	cpw	x, (0x25, sp)
	ld	a, (0x0f, sp)
	sbc	a, (0x24, sp)
	ld	a, (0x0e, sp)
	sbc	a, (0x23, sp)
	ld	a, (0x0d, sp)
	sbc	a, (0x22, sp)
	ld	a, (0x0c, sp)
	sbc	a, (0x21, sp)
	ld	a, (0x0b, sp)
	sbc	a, (0x20, sp)
	ld	a, (0x0a, sp)
	sbc	a, (0x1f, sp)
	jrc	00106$
;	../_divulonglong.c: 56: reste -= y;
	ldw	x, (0x10, sp)
	subw	x, (0x25, sp)
	ldw	(0x08, sp), x
	ld	a, (0x0f, sp)
	sbc	a, (0x24, sp)
	ld	(0x07, sp), a
	ld	a, (0x0e, sp)
	sbc	a, (0x23, sp)
	ld	(0x06, sp), a
	ld	a, (0x0d, sp)
	sbc	a, (0x22, sp)
	ld	(0x05, sp), a
	ld	a, (0x0c, sp)
	sbc	a, (0x21, sp)
	ld	(0x04, sp), a
	ld	a, (0x0b, sp)
	sbc	a, (0x20, sp)
	ld	(0x03, sp), a
	ld	a, (0x0a, sp)
	sbc	a, (0x1f, sp)
	ld	(0x02, sp), a
	ldw	y, (0x08, sp)
	ldw	(0x10, sp), y
	ldw	y, (0x06, sp)
	ldw	(0x0e, sp), y
	ldw	y, (0x04, sp)
	ldw	(0x0c, sp), y
	ldw	y, (0x02, sp)
	ldw	(0x0a, sp), y
;	../_divulonglong.c: 58: x |= 1L;
	ld	a, (0x1e, sp)
	or	a, #0x01
	ld	(0x09, sp), a
	ld	a, (0x1d, sp)
	ld	(0x08, sp), a
	ld	a, (0x1c, sp)
	ld	(0x07, sp), a
	ld	a, (0x1b, sp)
	ld	(0x06, sp), a
	ld	a, (0x1a, sp)
	ld	(0x05, sp), a
	ld	a, (0x19, sp)
	ld	(0x04, sp), a
	ld	a, (0x18, sp)
	ld	(0x03, sp), a
	ld	a, (0x17, sp)
	ld	(0x02, sp), a
	ldw	y, (0x08, sp)
	ldw	(0x1d, sp), y
	ldw	y, (0x06, sp)
	ldw	(0x1b, sp), y
	ldw	y, (0x04, sp)
	ldw	(0x19, sp), y
	ldw	y, (0x02, sp)
	ldw	(0x17, sp), y
00106$:
;	../_divulonglong.c: 61: while (--count);
	dec	(0x01, sp)
	jreq	00132$
	jpf	00105$
00132$:
;	../_divulonglong.c: 62: return x;
	ldw	x, (0x15, sp)
	ldw	y, (0x1d, sp)
	ldw	(#6, x), y
	ldw	y, (0x1b, sp)
	ldw	(#4, x), y
	ldw	y, (0x19, sp)
	ldw	(#2, x), y
	ldw	y, (0x17, sp)
	ldw	(x), y
;	../_divulonglong.c: 63: }
	addw	sp, #17
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
