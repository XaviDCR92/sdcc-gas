;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _fs2ulong
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fs2ulong
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
;	../_fs2ulong.c: 103: __fs2ulong (float a1)
;	-----------------------------------------
;	 function __fs2ulong
;	-----------------------------------------
___fs2ulong:
	sub	sp, #14
;	../_fs2ulong.c: 109: fl1.f = a1;
	ldw	y, (0x13, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x11, sp)
	ldw	(0x01, sp), y
;	../_fs2ulong.c: 111: if (!fl1.l || SIGN(fl1.l))
	ldw	x, (0x03, sp)
	ldw	y, (0x01, sp)
	tnzw	x
	jrne	00111$
	tnzw	y
	jreq	00101$
00111$:
	ld	a, (0x04, sp)
	ld	a, (0x03, sp)
	ldw	y, (0x01, sp)
	jrpl	00102$
00101$:
;	../_fs2ulong.c: 112: return (0);
	clrw	x
	clrw	y
	jra	00104$
00102$:
;	../_fs2ulong.c: 114: exp = EXP (fl1.l) - EXCESS - 24;
	ldw	x, (0x01, sp)
	ld	a, #0x80
	div	x, a
	clr	a
	ld	xh, a
	subw	x, #0x0096
	ldw	(0x05, sp), x
;	../_fs2ulong.c: 115: l = MANT (fl1.l);
	ldw	y, (0x03, sp)
	ldw	x, (0x01, sp)
	ld	a, xl
	and	a, #0x7f
	ld	xl, a
	clr	a
	rrwa	x
	or	a, #0x80
	ld	xl, a
	ldw	(0x09, sp), y
	ldw	(0x07, sp), x
;	../_fs2ulong.c: 117: l >>= -exp;
	ld	a, (0x06, sp)
	neg	a
	ldw	y, (0x09, sp)
	ldw	(0x0d, sp), y
	ldw	x, (0x07, sp)
	tnz	a
	jreq	00114$
00113$:
	sraw	x
	rrc	(0x0d, sp)
	rrc	(0x0e, sp)
	dec	a
	jrne	00113$
00114$:
	ldw	(0x07, sp), x
	ldw	y, (0x0d, sp)
;	../_fs2ulong.c: 119: return l;
	ldw	(0x09, sp), y
	ldw	x, y
	ldw	y, (0x07, sp)
00104$:
;	../_fs2ulong.c: 120: }
	addw	sp, #14
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
