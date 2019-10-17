;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _fsdiv
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fsdiv
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
;	../_fsdiv.c: 274: static float __fsdiv_org (float a1, float a2)
;	-----------------------------------------
;	 function __fsdiv_org
;	-----------------------------------------
___fsdiv_org:
	sub	sp, #34
;	../_fsdiv.c: 283: fl1.f = a1;
	ldw	y, (0x27, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x25, sp)
	ldw	(0x01, sp), y
;	../_fsdiv.c: 284: fl2.f = a2;
	ldw	y, (0x2b, sp)
	ldw	(0x07, sp), y
	ldw	y, (0x29, sp)
	ldw	(0x05, sp), y
;	../_fsdiv.c: 287: exp = EXP (fl1.l) ;
	ldw	x, (0x01, sp)
	ld	a, #0x80
	div	x, a
	clr	a
	ld	xh, a
	ldw	(0x0d, sp), x
;	../_fsdiv.c: 288: exp -= EXP (fl2.l);
	ldw	x, (0x05, sp)
	ld	a, #0x80
	div	x, a
	ld	a, xl
	ld	(0x16, sp), a
	clr	(0x15, sp)
	ldw	x, (0x0d, sp)
	subw	x, (0x15, sp)
;	../_fsdiv.c: 289: exp += EXCESS;
	ldw	(0x0d, sp), x
	addw	x, #0x007e
	ldw	(0x0d, sp), x
;	../_fsdiv.c: 292: sign = SIGN (fl1.l) ^ SIGN (fl2.l);
	ldw	x, (0x01, sp)
	sllw	x
	clr	a
	rlc	a
	ld	(0x16, sp), a
	ldw	x, (0x05, sp)
	sllw	x
	clr	a
	rlc	a
	xor	a, (0x16, sp)
	ld	(0x14, sp), a
;	../_fsdiv.c: 295: if (!fl2.l)
	ldw	y, (0x07, sp)
	ldw	(0x12, sp), y
	ldw	y, (0x05, sp)
	ldw	(0x10, sp), y
	ldw	x, (0x12, sp)
	jrne	00102$
;	../_fsdiv.c: 297: fl2.l = 0x7FC00000;
	ldw	x, (0x10, sp)
	jrne	00102$
	ldw	(0x07, sp), x
	ldw	x, #0x7fc0
	ldw	(0x05, sp), x
;	../_fsdiv.c: 298: return (fl2.f);
	ldw	x, (0x07, sp)
	ldw	y, (0x05, sp)
	jp	00118$
00102$:
;	../_fsdiv.c: 302: if (!fl1.l)
	ldw	x, (0x03, sp)
	ldw	y, (0x01, sp)
	tnzw	x
	jrne	00104$
	tnzw	y
	jrne	00104$
;	../_fsdiv.c: 303: return (0);
	clrw	x
	clrw	y
	jp	00118$
00104$:
;	../_fsdiv.c: 306: mant1 = MANT (fl1.l);
	ldw	y, (0x03, sp)
	ldw	x, (0x01, sp)
	ld	a, xl
	and	a, #0x7f
	ld	xl, a
	clr	a
	rrwa	x
	or	a, #0x80
	ld	xl, a
	ldw	(0x21, sp), y
	ldw	(0x1f, sp), x
;	../_fsdiv.c: 307: mant2 = MANT (fl2.l);
	ldw	y, (0x07, sp)
	ldw	x, (0x05, sp)
	ld	a, xl
	and	a, #0x7f
	ld	xl, a
	clr	a
	rrwa	x
	or	a, #0x80
	ld	xl, a
	ldw	(0x0b, sp), y
	ldw	(0x09, sp), x
;	../_fsdiv.c: 310: if (mant1 < mant2)
	ldw	x, (0x21, sp)
	cpw	x, (0x0b, sp)
	ld	a, (0x20, sp)
	sbc	a, (0x0a, sp)
	ld	a, (0x1f, sp)
	sbc	a, (0x09, sp)
	jrsge	00106$
;	../_fsdiv.c: 312: mant1 <<= 1;
	sll	(0x22, sp)
	rlc	(0x21, sp)
	rlc	(0x20, sp)
	rlc	(0x1f, sp)
;	../_fsdiv.c: 313: exp--;
	ldw	x, (0x0d, sp)
	decw	x
	ldw	(0x15, sp), x
	ldw	(0x0d, sp), x
00106$:
;	../_fsdiv.c: 317: mask = 0x1000000;
	clrw	x
	ldw	(0x1d, sp), x
	ldw	x, #0x0100
	ldw	(0x1b, sp), x
;	../_fsdiv.c: 318: result = 0;
	clrw	x
	ldw	(0x19, sp), x
	ldw	(0x17, sp), x
;	../_fsdiv.c: 319: while (mask)
00109$:
	ldw	x, (0x1d, sp)
	jrne	00179$
	ldw	x, (0x1b, sp)
	jreq	00111$
00179$:
;	../_fsdiv.c: 321: if (mant1 >= mant2)
	ldw	x, (0x21, sp)
	cpw	x, (0x0b, sp)
	ld	a, (0x20, sp)
	sbc	a, (0x0a, sp)
	ld	a, (0x1f, sp)
	sbc	a, (0x09, sp)
	jrslt	00108$
;	../_fsdiv.c: 323: result |= mask;
	ldw	x, (0x19, sp)
	ldw	y, (0x17, sp)
	ld	a, xl
	or	a, (0x1e, sp)
	rlwa	x
	or	a, (0x1d, sp)
	ld	xh, a
	ld	a, yl
	or	a, (0x1c, sp)
	rlwa	y
	or	a, (0x1b, sp)
	ld	yh, a
	ldw	(0x19, sp), x
	ldw	(0x17, sp), y
;	../_fsdiv.c: 324: mant1 -= mant2;
	ldw	y, (0x21, sp)
	subw	y, (0x0b, sp)
	ld	a, (0x20, sp)
	sbc	a, (0x0a, sp)
	ld	xl, a
	ld	a, (0x1f, sp)
	sbc	a, (0x09, sp)
	ld	xh, a
	ldw	(0x21, sp), y
	ldw	(0x1f, sp), x
00108$:
;	../_fsdiv.c: 326: mant1 <<= 1;
	sll	(0x22, sp)
	rlc	(0x21, sp)
	rlc	(0x20, sp)
	rlc	(0x1f, sp)
;	../_fsdiv.c: 327: mask >>= 1;
	srl	(0x1b, sp)
	rrc	(0x1c, sp)
	rrc	(0x1d, sp)
	rrc	(0x1e, sp)
	jra	00109$
00111$:
;	../_fsdiv.c: 331: result += 1;
	ldw	x, (0x19, sp)
	addw	x, #0x0001
	ldw	y, (0x17, sp)
	jrnc	00181$
	incw	y
00181$:
	ldw	(0x19, sp), x
	ldw	(0x17, sp), y
;	../_fsdiv.c: 334: exp++;
	ldw	x, (0x0d, sp)
	incw	x
	ldw	(0x0d, sp), x
;	../_fsdiv.c: 335: result >>= 1;
	sra	(0x17, sp)
	rrc	(0x18, sp)
	rrc	(0x19, sp)
	rrc	(0x1a, sp)
;	../_fsdiv.c: 337: result &= ~HIDDEN;
	ldw	y, (0x19, sp)
	ld	a, (0x18, sp)
	and	a, #0x7f
	ld	xl, a
	ld	a, (0x17, sp)
	ld	xh, a
	ldw	(0x19, sp), y
	ldw	(0x17, sp), x
;	../_fsdiv.c: 340: if (exp >= 0x100)
	ldw	x, (0x0d, sp)
	cpw	x, #0x0100
	jrslt	00116$
;	../_fsdiv.c: 341: fl1.l = (sign ? SIGNBIT : 0) | __INFINITY;
	tnz	(0x14, sp)
	jreq	00120$
	clrw	x
	ldw	(0x15, sp), x
	clr	(0x14, sp)
	ld	a, #0x80
	jra	00121$
00120$:
	clrw	x
	ldw	(0x15, sp), x
	clr	(0x14, sp)
	clr	a
00121$:
	or	a, #0x7f
	ld	yh, a
	ld	a, (0x16, sp)
	ld	xl, a
	ld	a, (0x15, sp)
	ld	xh, a
	ld	a, (0x14, sp)
	or	a, #0x80
	ld	yl, a
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
	jra	00117$
00116$:
;	../_fsdiv.c: 342: else if (exp < 0)
	tnz	(0x0d, sp)
	jrpl	00113$
;	../_fsdiv.c: 343: fl1.l = 0;
	clrw	x
	ldw	(0x03, sp), x
	ldw	(0x01, sp), x
	jra	00117$
00113$:
;	../_fsdiv.c: 345: fl1.l = PACK (sign ? SIGNBIT : 0 , exp, result);
	tnz	(0x14, sp)
	jreq	00122$
	clrw	x
	ldw	(0x15, sp), x
	ldw	x, #0x8000
	ldw	(0x13, sp), x
	jra	00123$
00122$:
	clrw	x
	ldw	(0x15, sp), x
	ldw	(0x13, sp), x
00123$:
	ldw	y, (0x0d, sp)
	clrw	x
	tnzw	y
	jrpl	00186$
	decw	x
00186$:
	clrw	x
	ld	a, #0x07
00187$:
	sllw	y
	dec	a
	jrne	00187$
	ld	a, xl
	or	a, (0x16, sp)
	ld	(0x12, sp), a
	ld	a, xh
	or	a, (0x15, sp)
	ld	(0x11, sp), a
	ld	a, yl
	or	a, (0x14, sp)
	ld	(0x10, sp), a
	ld	a, yh
	or	a, (0x13, sp)
	ldw	y, (0x19, sp)
	ldw	(0x15, sp), y
	ldw	y, (0x17, sp)
	pushw	y
	or	a, (1, sp)
	popw	y
	ld	yh, a
	ld	a, (0x12, sp)
	or	a, (0x16, sp)
	ld	xl, a
	ld	a, (0x11, sp)
	or	a, (0x15, sp)
	ld	xh, a
	pushw	y
	ld	a, (0x12, sp)
	or	a, (2, sp)
	popw	y
	ld	yl, a
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
00117$:
;	../_fsdiv.c: 346: return (fl1.f);
	ldw	x, (0x03, sp)
	ldw	y, (0x01, sp)
00118$:
;	../_fsdiv.c: 347: }
	addw	sp, #34
	ret
;	../_fsdiv.c: 349: float __fsdiv (float a1, float a2)
;	-----------------------------------------
;	 function __fsdiv
;	-----------------------------------------
___fsdiv:
	sub	sp, #6
;	../_fsdiv.c: 352: unsigned long *p = (unsigned long *) &f;
	ldw	x, sp
	incw	x
	ldw	(0x05, sp), x
;	../_fsdiv.c: 354: if (a2 == 0.0f && a1 > 0.0f)
	ldw	x, (0x0f, sp)
	jrne	00110$
	ldw	x, (0x0d, sp)
	sllw	x
	jrne	00110$
	ldw	x, (0x0b, sp)
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	clrw	x
	pushw	x
	clrw	x
	pushw	x
	call	___fslt
	addw	sp, #8
	tnz	a
	jreq	00110$
;	../_fsdiv.c: 355: *p = 0x7f800000; // inf
	ldw	x, (0x05, sp)
	clr	(0x3, x)
	clr	(0x2, x)
	ldw	y, #0x7f80
	ldw	(x), y
	jra	00111$
00110$:
;	../_fsdiv.c: 356: else if (a2 == 0.0f && a1 < 0.0f)
	ldw	x, (0x0f, sp)
	jrne	00106$
	ldw	x, (0x0d, sp)
	sllw	x
	jrne	00106$
	clrw	x
	pushw	x
	clrw	x
	pushw	x
	ldw	x, (0x0f, sp)
	pushw	x
	ldw	x, (0x0f, sp)
	pushw	x
	call	___fslt
	addw	sp, #8
	tnz	a
	jreq	00106$
;	../_fsdiv.c: 357: *p = 0xff800000; // -inf
	ldw	x, (0x05, sp)
	clr	(0x3, x)
	clr	(0x2, x)
	ldw	y, #0xff80
	ldw	(x), y
	jra	00111$
00106$:
;	../_fsdiv.c: 358: else if (a2 == 0.0f && a1 == 0.0f)
	ldw	x, (0x0f, sp)
	jrne	00102$
	ldw	x, (0x0d, sp)
	sllw	x
	jrne	00102$
	ldw	x, (0x0b, sp)
	jrne	00102$
	ldw	x, (0x09, sp)
	sllw	x
	jrne	00102$
;	../_fsdiv.c: 359: *p = 0xffc00000; // nan
	ldw	x, (0x05, sp)
	clr	(0x3, x)
	clr	(0x2, x)
	ldw	y, #0xffc0
	ldw	(x), y
	jra	00111$
00102$:
;	../_fsdiv.c: 361: f = __fsdiv_org (a1, a2);
	ldw	x, (0x0f, sp)
	pushw	x
	ldw	x, (0x0f, sp)
	pushw	x
	ldw	x, (0x0f, sp)
	pushw	x
	ldw	x, (0x0f, sp)
	pushw	x
	call	___fsdiv_org
	addw	sp, #8
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
00111$:
;	../_fsdiv.c: 363: return f; 
	ldw	x, (0x03, sp)
	ldw	y, (0x01, sp)
;	../_fsdiv.c: 364: }
	addw	sp, #6
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
