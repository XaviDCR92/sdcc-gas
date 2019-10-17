;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _divulong
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __divulong
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
;	../_divulong.c: 331: _divulong (unsigned long x, unsigned long y)
;	-----------------------------------------
;	 function _divulong
;	-----------------------------------------
__divulong:
	sub	sp, #8
;	../_divulong.c: 333: unsigned long reste = 0L;
	clrw	x
	ldw	(0x07, sp), x
	clrw	y
;	../_divulong.c: 334: unsigned char count = 32;
	ld	a, #0x20
;	../_divulong.c: 337: do
00105$:
;	../_divulong.c: 340: c = MSB_SET(x);
	push	a
	ld	a, (0x0d, sp)
	sll	a
	clr	a
	rlc	a
	ld	(0x05, sp), a
	pop	a
;	../_divulong.c: 341: x <<= 1;
	sll	(0x0f, sp)
	rlc	(0x0e, sp)
	rlc	(0x0d, sp)
	rlc	(0x0c, sp)
;	../_divulong.c: 342: reste <<= 1;
	sll	(0x08, sp)
	rlc	(0x07, sp)
	rlcw	y
;	../_divulong.c: 343: if (c)
	tnz	(0x04, sp)
	jreq	00102$
;	../_divulong.c: 344: reste |= 1L;
	push	a
	ldw	x, (0x08, sp)
	srlw	x
	scf
	rlcw	x
	pop	a
	ldw	(0x07, sp), x
00102$:
;	../_divulong.c: 346: if (reste >= y)
	ldw	x, (0x07, sp)
	cpw	x, (0x12, sp)
	push	a
	ld	a, yl
	sbc	a, (0x12, sp)
	ld	a, yh
	sbc	a, (0x11, sp)
	pop	a
	jrc	00106$
;	../_divulong.c: 348: reste -= y;
	ldw	x, (0x07, sp)
	subw	x, (0x12, sp)
	push	a
	ld	a, yl
	sbc	a, (0x12, sp)
	rlwa	y
	sbc	a, (0x11, sp)
	ld	yh, a
	pop	a
	ldw	(0x07, sp), x
;	../_divulong.c: 350: x |= 1L;
	push	a
	ld	a, (0x10, sp)
	or	a, #0x01
	ld	(0x05, sp), a
	ld	a, (0x0f, sp)
	ld	(0x04, sp), a
	ld	a, (0x0e, sp)
	ld	(0x03, sp), a
	ld	a, (0x0d, sp)
	ld	(0x02, sp), a
	pop	a
	ldw	x, (0x03, sp)
	ldw	(0x0e, sp), x
	ldw	x, (0x01, sp)
	ldw	(0x0c, sp), x
00106$:
;	../_divulong.c: 353: while (--count);
	dec	a
	ld	xl, a
	tnz	a
	exg	a, xl
	jrne	00105$
;	../_divulong.c: 354: return x;
	ldw	x, (0x0e, sp)
	ldw	y, (0x0c, sp)
;	../_divulong.c: 355: }
	addw	sp, #8
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
