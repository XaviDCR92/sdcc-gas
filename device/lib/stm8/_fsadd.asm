;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _fsadd
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fsadd
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
;	../_fsadd.c: 170: float __fsadd (float a1, float a2)
;	-----------------------------------------
;	 function __fsadd
;	-----------------------------------------
___fsadd:
	sub	sp, #22
;	../_fsadd.c: 178: pfl2 = (long _AUTOMEM *)&a2;
	ldw	x, sp
	addw	x, #29
;	../_fsadd.c: 179: exp2 = EXP (*pfl2);
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	(0x11, sp), y
	ldw	x, (x)
	ldw	(0x0f, sp), x
	ldw	y, (0x11, sp)
	ldw	(0x15, sp), y
	ldw	y, (0x0f, sp)
	ldw	(0x13, sp), y
	ldw	x, y
	ld	a, #0x80
	div	x, a
	clr	a
	ld	xh, a
	ldw	(0x01, sp), x
;	../_fsadd.c: 180: mant2 = MANT (*pfl2) << 4;
	ldw	y, (0x11, sp)
	ld	a, (0x10, sp)
	and	a, #0x7f
	ld	xh, a
	clr	a
	ld	xl, a
	sllw	x
	scf
	rrcw	x
	swapw	x
	ld	a, #0x04
00240$:
	sllw	y
	rlcw	x
	dec	a
	jrne	00240$
	ldw	(0x05, sp), y
	ldw	(0x03, sp), x
;	../_fsadd.c: 181: if (SIGN (*pfl2))
	tnz	(0x13, sp)
	jrpl	00102$
;	../_fsadd.c: 182: mant2 = -mant2;
	ldw	y, (0x05, sp)
	negw	y
	ldw	x, (0x03, sp)
	jrnc	00243$
	incw	x
00243$:
	negw	x
	ldw	(0x05, sp), y
	ldw	(0x03, sp), x
00102$:
;	../_fsadd.c: 184: if (!*pfl2)
	ldw	x, (0x11, sp)
	jrne	00104$
	ldw	x, (0x0f, sp)
	jrne	00104$
;	../_fsadd.c: 185: return (a1);
	ldw	x, (0x1b, sp)
	ldw	y, (0x19, sp)
	jp	00137$
00104$:
;	../_fsadd.c: 187: pfl1 = (long _AUTOMEM *)&a1;
	ldw	x, sp
	addw	x, #25
;	../_fsadd.c: 188: exp1 = EXP (*pfl1);
	ldw	(0x07, sp), x
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	(0x0b, sp), y
	ldw	x, (x)
	ldw	(0x09, sp), x
	ldw	y, (0x0b, sp)
	ldw	(0x15, sp), y
	ldw	y, (0x09, sp)
	ldw	(0x13, sp), y
	ldw	x, y
	ld	a, #0x80
	div	x, a
	clr	a
	ld	xh, a
	ldw	(0x0d, sp), x
;	../_fsadd.c: 189: mant1 = MANT (*pfl1) << 4;
	ldw	y, (0x0b, sp)
	ld	a, (0x0a, sp)
	and	a, #0x7f
	ld	xh, a
	clr	a
	ld	xl, a
	sllw	x
	scf
	rrcw	x
	swapw	x
	ld	a, #0x04
00246$:
	sllw	y
	rlcw	x
	dec	a
	jrne	00246$
	ldw	(0x11, sp), y
	ldw	(0x0f, sp), x
;	../_fsadd.c: 190: if (SIGN(*pfl1))
	tnz	(0x13, sp)
	jrpl	00108$
;	../_fsadd.c: 191: if (*pfl1 & 0x80000000)
	tnz	(0x09, sp)
	jrpl	00108$
;	../_fsadd.c: 192: mant1 = -mant1;
	ld	a, (0x12, sp)
	neg	a
	ld	(0x16, sp), a
	clr	a
	sbc	a, (0x11, sp)
	ld	(0x15, sp), a
	clr	a
	sbc	a, (0x10, sp)
	ld	(0x14, sp), a
	clr	a
	sbc	a, (0x0f, sp)
	ld	(0x0f, sp), a
	ldw	y, (0x15, sp)
	ldw	(0x11, sp), y
	ld	a, (0x14, sp)
	ld	(0x10, sp), a
00108$:
;	../_fsadd.c: 194: if (!*pfl1)
	ldw	x, (0x0b, sp)
	jrne	00110$
	ldw	x, (0x09, sp)
	jrne	00110$
;	../_fsadd.c: 195: return (a2);
	ldw	x, (0x1f, sp)
	ldw	y, (0x1d, sp)
	jp	00137$
00110$:
;	../_fsadd.c: 197: expd = exp1 - exp2;
	ldw	x, (0x0d, sp)
	subw	x, (0x01, sp)
;	../_fsadd.c: 198: if (expd > 25)
	ldw	(0x15, sp), x
	cpw	x, #0x0019
	jrsle	00112$
;	../_fsadd.c: 199: return (a1);
	ldw	x, (0x1b, sp)
	ldw	y, (0x19, sp)
	jp	00137$
00112$:
;	../_fsadd.c: 200: if (expd < -25)
	ldw	x, (0x15, sp)
	cpw	x, #0xffe7
	jrsge	00114$
;	../_fsadd.c: 201: return (a2);
	ldw	x, (0x1f, sp)
	ldw	y, (0x1d, sp)
	jp	00137$
00114$:
;	../_fsadd.c: 203: if (expd < 0)
	tnz	(0x15, sp)
	jrpl	00116$
;	../_fsadd.c: 205: expd = -expd;
	ldw	x, (0x15, sp)
	negw	x
;	../_fsadd.c: 206: exp1 += expd;
	ldw	(0x15, sp), x
	addw	x, (0x0d, sp)
	ldw	(0x0d, sp), x
;	../_fsadd.c: 207: mant1 >>= expd;
	ldw	x, (0x11, sp)
	ldw	y, (0x0f, sp)
	ld	a, (0x16, sp)
	jreq	00256$
00255$:
	sraw	y
	rrcw	x
	dec	a
	jrne	00255$
00256$:
	ldw	(0x11, sp), x
	ldw	(0x0f, sp), y
	jra	00117$
00116$:
;	../_fsadd.c: 211: mant2 >>= expd;
	ldw	x, (0x05, sp)
	ldw	y, (0x03, sp)
	ld	a, (0x16, sp)
	jreq	00258$
00257$:
	sraw	y
	rrcw	x
	dec	a
	jrne	00257$
00258$:
	ldw	(0x05, sp), x
	ldw	(0x03, sp), y
00117$:
;	../_fsadd.c: 213: mant1 += mant2;
	ldw	y, (0x11, sp)
	addw	y, (0x05, sp)
	ldw	x, (0x0f, sp)
	jrnc	00259$
	incw	x
00259$:
	addw	x, (0x03, sp)
	ldw	(0x13, sp), y
	ldw	(0x11, sp), x
;	../_fsadd.c: 215: sign = false;
	clr	(0x10, sp)
;	../_fsadd.c: 217: if (mant1 < 0)
	tnz	(0x11, sp)
	jrpl	00121$
;	../_fsadd.c: 219: mant1 = -mant1;
	ldw	y, (0x13, sp)
	negw	y
	ldw	x, (0x11, sp)
	jrnc	00261$
	incw	x
00261$:
	negw	x
	ldw	(0x13, sp), y
	ldw	(0x11, sp), x
;	../_fsadd.c: 220: sign = true;
	ld	a, #0x01
	ld	(0x10, sp), a
	jra	00154$
00121$:
;	../_fsadd.c: 222: else if (!mant1)
	ldw	x, (0x13, sp)
	jrne	00154$
;	../_fsadd.c: 223: return (0);
	ldw	x, (0x11, sp)
	jrne	00154$
	clrw	y
	jp	00137$
;	../_fsadd.c: 226: while (mant1 < (HIDDEN<<4)) {
00154$:
	ldw	y, (0x0d, sp)
	ldw	(0x15, sp), y
00123$:
	ldw	x, (0x11, sp)
	cpw	x, #0x0800
	jrnc	00157$
;	../_fsadd.c: 227: mant1 <<= 1;
	sll	(0x14, sp)
	rlc	(0x13, sp)
	rlc	(0x12, sp)
	rlc	(0x11, sp)
;	../_fsadd.c: 228: exp1--;
	ldw	x, (0x15, sp)
	decw	x
	ldw	(0x15, sp), x
	jra	00123$
;	../_fsadd.c: 232: while (mant1 & 0xf0000000) {
00157$:
00128$:
	ld	a, (0x11, sp)
	bcp	a, #0xf0
	jreq	00163$
;	../_fsadd.c: 233: if (mant1&1)
	ld	a, (0x14, sp)
	srl	a
	jrnc	00127$
;	../_fsadd.c: 234: mant1 += 2;
	ldw	x, (0x13, sp)
	addw	x, #0x0002
	ldw	y, (0x11, sp)
	jrnc	00267$
	incw	y
00267$:
	ldw	(0x13, sp), x
	ldw	(0x11, sp), y
00127$:
;	../_fsadd.c: 235: mant1 >>= 1;
	sra	(0x11, sp)
	rrc	(0x12, sp)
	rrc	(0x13, sp)
	rrc	(0x14, sp)
;	../_fsadd.c: 236: exp1++;
	ldw	x, (0x15, sp)
	incw	x
	ldw	(0x15, sp), x
	jra	00128$
00163$:
	ldw	y, (0x15, sp)
	ldw	(0x0a, sp), y
;	../_fsadd.c: 240: mant1 &= ~(HIDDEN<<4);
	ldw	y, (0x13, sp)
	ldw	(0x0e, sp), y
	ld	a, (0x12, sp)
	ld	(0x0d, sp), a
	ld	a, (0x11, sp)
	and	a, #0xf7
	ld	(0x0c, sp), a
	ldw	y, (0x0e, sp)
	ldw	(0x13, sp), y
	ldw	y, (0x0c, sp)
	ldw	(0x11, sp), y
;	../_fsadd.c: 243: if (exp1 >= 0x100)
	ldw	x, (0x15, sp)
	cpw	x, #0x0100
	jrslt	00135$
;	../_fsadd.c: 244: *pfl1 = (sign ? (SIGNBIT | __INFINITY) : __INFINITY);
	tnz	(0x10, sp)
	jreq	00139$
	clrw	x
	ldw	(0x15, sp), x
	ldw	x, #0xff80
	ldw	(0x13, sp), x
	jra	00140$
00139$:
	clrw	x
	ldw	(0x15, sp), x
	ldw	x, #0x7f80
	ldw	(0x13, sp), x
00140$:
	ldw	x, (0x07, sp)
	ldw	y, (0x15, sp)
	ldw	(0x2, x), y
	ldw	y, (0x13, sp)
	ldw	(x), y
	jp	00136$
00135$:
;	../_fsadd.c: 245: else if (exp1 < 0)
	tnz	(0x15, sp)
	jrpl	00132$
;	../_fsadd.c: 246: *pfl1 = 0;
	ldw	x, (0x07, sp)
	clr	(0x3, x)
	clr	(0x2, x)
	clr	(0x1, x)
	clr	(x)
	jp	00136$
00132$:
;	../_fsadd.c: 248: *pfl1 = PACK (sign ? SIGNBIT : 0 , exp1, mant1>>4);
	tnz	(0x10, sp)
	jreq	00141$
	clrw	x
	ldw	(0x05, sp), x
	ldw	x, #0x8000
	ldw	(0x03, sp), x
	jra	00142$
00141$:
	clrw	x
	ldw	(0x05, sp), x
	ldw	(0x03, sp), x
00142$:
	ldw	y, (0x0a, sp)
	ldw	(0x0f, sp), y
	ld	a, (0x0f, sp)
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	(0x0e, sp), a
	ld	(0x0d, sp), a
	ldw	y, (0x0f, sp)
	ldw	(0x0d, sp), y
	clrw	x
	ldw	(0x0f, sp), x
	ld	a, #0x07
00273$:
	sll	(0x0e, sp)
	rlc	(0x0d, sp)
	dec	a
	jrne	00273$
	ld	a, (0x06, sp)
	or	a, (0x10, sp)
	ld	(0x0c, sp), a
	ld	a, (0x05, sp)
	or	a, (0x0f, sp)
	ld	(0x0b, sp), a
	ld	a, (0x04, sp)
	or	a, (0x0e, sp)
	ld	(0x0a, sp), a
	ld	a, (0x03, sp)
	or	a, (0x0d, sp)
	ld	(0x09, sp), a
	ldw	y, (0x11, sp)
	ldw	(0x03, sp), y
	ldw	x, (0x13, sp)
	sra	(0x03, sp)
	rrc	(0x04, sp)
	rrcw	x
	sra	(0x03, sp)
	rrc	(0x04, sp)
	rrcw	x
	sra	(0x03, sp)
	rrc	(0x04, sp)
	rrcw	x
	sra	(0x03, sp)
	rrc	(0x04, sp)
	rrcw	x
	ldw	(0x05, sp), x
	ldw	(0x15, sp), x
	ldw	y, (0x03, sp)
	ldw	(0x13, sp), y
	ld	a, (0x0c, sp)
	or	a, (0x16, sp)
	ld	(0x12, sp), a
	ld	a, (0x0b, sp)
	or	a, (0x15, sp)
	ld	(0x11, sp), a
	ld	a, (0x0a, sp)
	or	a, (0x14, sp)
	ld	(0x10, sp), a
	ld	a, (0x09, sp)
	or	a, (0x13, sp)
	ld	(0x0f, sp), a
	ldw	x, (0x07, sp)
	ldw	y, (0x11, sp)
	ldw	(0x2, x), y
	ldw	y, (0x0f, sp)
	ldw	(x), y
00136$:
;	../_fsadd.c: 249: return (a1);
	ldw	x, (0x1b, sp)
	ldw	y, (0x19, sp)
00137$:
;	../_fsadd.c: 250: }
	addw	sp, #22
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
