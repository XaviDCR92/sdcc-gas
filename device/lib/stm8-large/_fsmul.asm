;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _fsmul
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fsmul
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
;	../_fsmul.c: 241: float __fsmul (float a1, float a2) {
;	-----------------------------------------
;	 function __fsmul
;	-----------------------------------------
___fsmul:
	sub	sp, #21
;	../_fsmul.c: 247: fl1.f = a1;
	ldw	y, (0x1b, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x19, sp)
	ldw	(0x01, sp), y
;	../_fsmul.c: 248: fl2.f = a2;
	ldw	y, (0x1f, sp)
	ldw	(0x07, sp), y
	ldw	y, (0x1d, sp)
	ldw	(0x05, sp), y
;	../_fsmul.c: 250: if (!fl1.l || !fl2.l)
	ldw	y, (0x03, sp)
	ldw	(0x14, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x12, sp), y
	ldw	x, (0x14, sp)
	jrne	00149$
	ldw	x, (0x12, sp)
	jreq	00101$
00149$:
	ldw	x, (0x07, sp)
	ldw	y, (0x05, sp)
	tnzw	x
	jrne	00102$
	tnzw	y
	jrne	00102$
00101$:
;	../_fsmul.c: 251: return (0);
	clrw	x
	clrw	y
	jpf	00113$
00102$:
;	../_fsmul.c: 254: sign = SIGN (fl1.l) ^ SIGN (fl2.l);
	ldw	x, (0x01, sp)
	sllw	x
	clr	a
	rlc	a
	ld	(0x15, sp), a
	ldw	x, (0x05, sp)
	sllw	x
	clr	a
	rlc	a
	xor	a, (0x15, sp)
	ld	(0x0d, sp), a
;	../_fsmul.c: 255: exp = EXP (fl1.l) - EXCESS;
	ldw	x, (0x01, sp)
	ld	a, #0x80
	div	x, a
	clr	a
	ld	xh, a
	subw	x, #0x007e
	ldw	(0x14, sp), x
;	../_fsmul.c: 256: exp += EXP (fl2.l);
	ldw	x, (0x05, sp)
	ld	a, #0x80
	div	x, a
	clr	a
	ld	xh, a
	addw	x, (0x14, sp)
	ldw	(0x0e, sp), x
;	../_fsmul.c: 258: fl1.l = MANT (fl1.l);
	ldw	y, (0x03, sp)
	ldw	x, (0x01, sp)
	ld	a, xl
	and	a, #0x7f
	ld	xl, a
	clr	a
	rrwa	x
	or	a, #0x80
	ld	xl, a
	ldw	(0x03, sp), y
	ldw	(0x01, sp), x
;	../_fsmul.c: 259: fl2.l = MANT (fl2.l);
	ldw	y, (0x07, sp)
	ldw	x, (0x05, sp)
	ld	a, xl
	and	a, #0x7f
	ld	xl, a
	clr	a
	rrwa	x
	or	a, #0x80
	ld	xl, a
	ldw	(0x07, sp), y
	ldw	(0x05, sp), x
;	../_fsmul.c: 262: result = (unsigned long)((unsigned short)(fl1.l >> 8)) * (unsigned short)(fl2.l >> 8);
	ldw	y, (0x03, sp)
	ldw	x, (0x01, sp)
	ld	a, xl
	rlwa	y
	ld	(0x11, sp), a
	rrwa	y
	ld	(0x10, sp), a
	ldw	x, (0x07, sp)
	ldw	(0x14, sp), x
	ldw	x, (0x05, sp)
	ld	a, (0x14, sp)
	ld	(0x15, sp), a
	ldw	(0x13, sp), x
	clr	(0x12, sp)
	ld	a, (0x15, sp)
	rlwa	x
	ld	a, (0x14, sp)
	rrwa	x
	ld	xl, a
	pushw	x
	ldw	x, (0x12, sp)
	pushw	x
	callf	___muluint2ulong
	addw	sp, #4
	ldw	(0x0b, sp), x
	ldw	(0x09, sp), y
;	../_fsmul.c: 263: result += ((unsigned long)((unsigned short)(fl1.l & 0xff)) * (unsigned short)(fl2.l >> 8)) >> 8;
	ldw	y, (0x03, sp)
	clr	a
	ld	yh, a
	ldw	x, (0x07, sp)
	ldw	(0x14, sp), x
	ldw	x, (0x05, sp)
	ld	a, (0x14, sp)
	ld	(0x15, sp), a
	ldw	(0x13, sp), x
	clr	(0x12, sp)
	ld	a, (0x15, sp)
	rlwa	x
	ld	a, (0x14, sp)
	rrwa	x
	ld	xl, a
	pushw	x
	pushw	y
	callf	___muluint2ulong
	addw	sp, #4
	ld	a, xh
	ld	(0x15, sp), a
	ldw	(0x13, sp), y
	clr	(0x12, sp)
	ldw	x, (0x0b, sp)
	addw	x, (0x14, sp)
	ldw	y, (0x09, sp)
	jrnc	00152$
	incw	y
00152$:
	addw	y, (0x12, sp)
	ldw	(0x0b, sp), x
	ldw	(0x09, sp), y
;	../_fsmul.c: 264: result += ((unsigned long)((unsigned short)(fl2.l & 0xff)) * (unsigned short)(fl1.l >> 8)) >> 8;
	ldw	y, (0x07, sp)
	clr	a
	ld	yh, a
	ldw	x, (0x03, sp)
	ldw	(0x14, sp), x
	ldw	x, (0x01, sp)
	ld	a, (0x14, sp)
	ld	(0x15, sp), a
	ldw	(0x13, sp), x
	clr	(0x12, sp)
	ld	a, (0x15, sp)
	rlwa	x
	ld	a, (0x14, sp)
	rrwa	x
	ld	xl, a
	pushw	x
	pushw	y
	callf	___muluint2ulong
	addw	sp, #4
	ld	a, xh
	ld	(0x15, sp), a
	ldw	(0x13, sp), y
	clr	(0x12, sp)
	ldw	x, (0x0b, sp)
	addw	x, (0x14, sp)
	ldw	y, (0x09, sp)
	jrnc	00153$
	incw	y
00153$:
	addw	y, (0x12, sp)
	ldw	(0x0b, sp), x
	ldw	(0x09, sp), y
;	../_fsmul.c: 267: result += 0x40;
	ldw	x, (0x0b, sp)
	addw	x, #0x0040
	ldw	y, (0x09, sp)
	jrnc	00154$
	incw	y
00154$:
	ldw	(0x0b, sp), x
	ldw	(0x09, sp), y
;	../_fsmul.c: 269: if (result & SIGNBIT)
	tnz	(0x09, sp)
	jrpl	00105$
;	../_fsmul.c: 272: result += 0x40;
	ldw	x, (0x0b, sp)
	addw	x, #0x0040
	ldw	y, (0x09, sp)
	jrnc	00156$
	incw	y
00156$:
	ldw	(0x0b, sp), x
	ldw	(0x09, sp), y
;	../_fsmul.c: 273: result >>= 8;
	ldw	y, (0x0a, sp)
	ld	a, (0x09, sp)
	ld	xl, a
	clr	a
	ld	xh, a
	ldw	(0x0b, sp), y
	ldw	(0x09, sp), x
	jra	00106$
00105$:
;	../_fsmul.c: 277: result >>= 7;
	ldw	x, (0x0b, sp)
	ldw	y, (0x09, sp)
	clr	a
	rrwa	y
	rrwa	x
	sll	a
	rlcw	x
	rlcw	y
	ldw	(0x0b, sp), x
	ldw	(0x09, sp), y
;	../_fsmul.c: 278: exp--;
	ldw	x, (0x0e, sp)
	decw	x
	ldw	(0x0e, sp), x
00106$:
;	../_fsmul.c: 281: result &= ~HIDDEN;
	ldw	y, (0x0b, sp)
	ld	a, (0x0a, sp)
	and	a, #0x7f
	ld	xl, a
	ld	a, (0x09, sp)
	ld	xh, a
	ldw	(0x0b, sp), y
	ldw	(0x09, sp), x
;	../_fsmul.c: 284: if (exp >= 0x100)
	ldw	x, (0x0e, sp)
	cpw	x, #0x0100
	jrslt	00111$
;	../_fsmul.c: 285: fl1.l = (sign ? SIGNBIT : 0) | __INFINITY;
	tnz	(0x0d, sp)
	jreq	00115$
	clrw	x
	ldw	(0x14, sp), x
	clr	(0x13, sp)
	ld	a, #0x80
	jra	00116$
00115$:
	clrw	x
	ldw	(0x14, sp), x
	clr	(0x13, sp)
	clr	a
00116$:
	or	a, #0x7f
	ld	yh, a
	ld	a, (0x15, sp)
	ld	xl, a
	ld	a, (0x14, sp)
	ld	xh, a
	ld	a, (0x13, sp)
	or	a, #0x80
	ld	yl, a
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
	jra	00112$
00111$:
;	../_fsmul.c: 286: else if (exp < 0)
	tnz	(0x0e, sp)
	jrpl	00108$
;	../_fsmul.c: 287: fl1.l = 0;
	clrw	x
	ldw	(0x03, sp), x
	ldw	(0x01, sp), x
	jra	00112$
00108$:
;	../_fsmul.c: 289: fl1.l = PACK (sign ? SIGNBIT : 0 , exp, result);
	tnz	(0x0d, sp)
	jreq	00117$
	clrw	x
	ldw	(0x14, sp), x
	ldw	x, #0x8000
	ldw	(0x12, sp), x
	jra	00118$
00117$:
	clrw	x
	ldw	(0x14, sp), x
	ldw	(0x12, sp), x
00118$:
	ldw	y, (0x0e, sp)
	clrw	x
	tnzw	y
	jrpl	00161$
	decw	x
00161$:
	ld	a, yl
	clrw	x
	push	a
	ld	a, #0x07
00162$:
	sll	(1, sp)
	rlwa	y
	rlc	a
	rrwa	y
	dec	a
	jrne	00162$
	pop	a
	or	a, (0x13, sp)
	ld	yl, a
	ld	a, xl
	or	a, (0x15, sp)
	rlwa	x
	or	a, (0x14, sp)
	ld	xh, a
	ld	a, yh
	or	a, (0x12, sp)
	or	a, (0x09, sp)
	ld	yh, a
	ld	a, xl
	or	a, (0x0c, sp)
	rlwa	x
	or	a, (0x0b, sp)
	ld	xh, a
	ld	a, yl
	or	a, (0x0a, sp)
	ld	yl, a
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
00112$:
;	../_fsmul.c: 290: return (fl1.f);
	ldw	x, (0x03, sp)
	ldw	y, (0x01, sp)
00113$:
;	../_fsmul.c: 291: }
	addw	sp, #21
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
