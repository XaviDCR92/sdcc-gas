;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _rlulonglong
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __rlulonglong
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
;	../_rlulonglong.c: 37: unsigned long long _rlulonglong(unsigned long long l, char s)
;	-----------------------------------------
;	 function _rlulonglong
;	-----------------------------------------
__rlulonglong:
	sub	sp, #16
;	../_rlulonglong.c: 39: uint32_t *const top = (uint32_t *)((char *)(&l) + 0);
	ldw	y, sp
	addw	y, #19
	ldw	x, y
	ldw	(0x05, sp), x
;	../_rlulonglong.c: 40: uint16_t *const middle = (uint16_t *)((char *)(&l) + 4);
	ldw	x, y
	addw	x, #0x0004
	ldw	(0x07, sp), x
;	../_rlulonglong.c: 41: uint32_t *const bottom = (uint32_t *)((char *)(&l) + 4);
	ldw	x, y
	addw	x, #0x0004
	ldw	(0x09, sp), x
;	../_rlulonglong.c: 42: uint16_t *const b = (uint16_t *)(&l);
	ldw	(0x0b, sp), y
;	../_rlulonglong.c: 52: (*top) <<= s;
00103$:
;	../_rlulonglong.c: 44: for(;s >= 16; s-= 16)
	ld	a, (0x1d, sp)
	cp	a, #0x10
	jrc	00101$
;	../_rlulonglong.c: 46: b[0] = b[1];
	ldw	x, (0x0b, sp)
	incw	x
	incw	x
	ldw	(0x0f, sp), x
	ldw	x, (x)
	ldw	y, (0x0b, sp)
	ldw	(y), x
;	../_rlulonglong.c: 47: b[1] = b[2];
	ldw	x, (0x0b, sp)
	addw	x, #0x0004
	ldw	(0x0d, sp), x
	ldw	x, (x)
	ldw	y, (0x0f, sp)
	ldw	(y), x
;	../_rlulonglong.c: 48: b[2] = b[3];
	ldw	x, (0x0b, sp)
	addw	x, #0x0006
	ldw	(0x0f, sp), x
	ldw	x, (x)
	ldw	y, (0x0d, sp)
	ldw	(y), x
;	../_rlulonglong.c: 49: b[3] = 0;
	ldw	x, (0x0f, sp)
	clr	(0x1, x)
	clr	(x)
;	../_rlulonglong.c: 44: for(;s >= 16; s-= 16)
	ld	a, (0x1d, sp)
	sub	a, #0x10
	ld	(0x1d, sp), a
	jra	00103$
00101$:
;	../_rlulonglong.c: 52: (*top) <<= s;
	ldw	x, (0x05, sp)
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	x, (x)
	ld	a, (0x1d, sp)
	ld	(0x0c, sp), a
	jreq	00119$
00118$:
	sllw	y
	rlcw	x
	dec	a
	jrne	00118$
00119$:
	ldw	(0x0f, sp), y
	ldw	(0x0d, sp), x
	ldw	x, (0x05, sp)
	ldw	y, (0x0f, sp)
	ldw	(0x2, x), y
	ldw	y, (0x0d, sp)
	ldw	(x), y
;	../_rlulonglong.c: 53: (*top) |= (((uint32_t)((*middle) & 0xffffu) << s) >> 16);
	ldw	x, (0x07, sp)
	ldw	x, (x)
	exgw	x, y
	clrw	x
	ldw	(0x03, sp), y
	ld	a, (0x0c, sp)
	jreq	00121$
00120$:
	sll	(0x04, sp)
	rlc	(0x03, sp)
	rlcw	x
	dec	a
	jrne	00120$
00121$:
	ldw	y, x
	ld	a, xl
	clrw	x
	or	a, (0x10, sp)
	ld	(0x04, sp), a
	ld	a, yh
	or	a, (0x0f, sp)
	ld	(0x03, sp), a
	ld	a, xl
	or	a, (0x0e, sp)
	ld	(0x02, sp), a
	ld	a, xh
	or	a, (0x0d, sp)
	ld	(0x01, sp), a
	ldw	x, (0x05, sp)
	ldw	y, (0x03, sp)
	ldw	(0x2, x), y
	ldw	y, (0x01, sp)
	ldw	(x), y
;	../_rlulonglong.c: 54: (*bottom) <<= s;
	ldw	x, (0x09, sp)
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	x, (x)
	ld	a, (0x0c, sp)
	jreq	00123$
00122$:
	sllw	y
	rlcw	x
	dec	a
	jrne	00122$
00123$:
	ldw	(0x0f, sp), y
	ldw	(0x0d, sp), x
	ldw	x, (0x09, sp)
	ldw	y, (0x0f, sp)
	ldw	(0x2, x), y
	ldw	y, (0x0d, sp)
	ldw	(x), y
;	../_rlulonglong.c: 56: return(l);
	ldw	x, (0x13, sp)
	ldw	y, (0x1b, sp)
	ldw	(#6, x), y
	ldw	y, (0x19, sp)
	ldw	(#4, x), y
	ldw	y, (0x17, sp)
	ldw	(#2, x), y
	ldw	y, (0x15, sp)
	ldw	(x), y
;	../_rlulonglong.c: 57: }
	addw	sp, #16
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
