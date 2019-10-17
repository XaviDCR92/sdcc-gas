;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module mbtowc
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _mbtowc
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
;	../mbtowc.c: 31: int mbtowc(wchar_t *pwc, const char *restrict s, size_t n)
;	-----------------------------------------
;	 function mbtowc
;	-----------------------------------------
_mbtowc:
	sub	sp, #12
;	../mbtowc.c: 37: if(!s)
;	../mbtowc.c: 38: return(0);
	ldw	x, (0x11, sp)
	jrne	00102$
	jp	00126$
00102$:
;	../mbtowc.c: 40: seqlen = 1;
	ld	a, #0x01
	ld	(0x0b, sp), a
;	../mbtowc.c: 41: first_byte = *s;
	ldw	y, (0x11, sp)
	ldw	(0x05, sp), y
	ldw	x, y
	ld	a, (x)
;	../mbtowc.c: 43: if(first_byte & 0x80)
	ld	(0x0c, sp), a
	jrpl	00107$
;	../mbtowc.c: 45: while (first_byte & (0x80 >> seqlen))
	ld	a, #0x01
	ld	(0x07, sp), a
00103$:
	ldw	x, #0x0080
	ld	a, (0x07, sp)
	jreq	00204$
00203$:
	sraw	x
	dec	a
	jrne	00203$
00204$:
	ld	a, (0x0c, sp)
	ld	(0x09, sp), a
	clr	(0x08, sp)
;	../mbtowc.c: 46: seqlen++;
	ld	a, (0x07, sp)
	inc	a
;	../mbtowc.c: 45: while (first_byte & (0x80 >> seqlen))
	push	a
	ld	a, xl
	and	a, (0x0a, sp)
	ld	(0x0c, sp), a
	ld	a, xh
	and	a, (0x09, sp)
	ld	(0x0b, sp), a
	pop	a
	ldw	x, (0x0a, sp)
	jreq	00143$
;	../mbtowc.c: 46: seqlen++;
	ld	(0x07, sp), a
	jra	00103$
00143$:
	push	a
	ld	a, (0x08, sp)
	ld	(0x0c, sp), a
	pop	a
;	../mbtowc.c: 47: first_byte &= (0xff >> (seqlen + 1));
	ldw	x, #0x00ff
	tnz	a
	jreq	00207$
00206$:
	sraw	x
	dec	a
	jrne	00206$
00207$:
	ld	a, xl
	and	a, (0x0c, sp)
	ld	(0x0c, sp), a
00107$:
;	../mbtowc.c: 50: if(seqlen > 4 || n < seqlen)
	ld	a, (0x0b, sp)
	cp	a, #0x04
	jrugt	00108$
	ld	a, (0x0b, sp)
	ld	(0x0a, sp), a
	clr	(0x09, sp)
	ldw	x, (0x13, sp)
	cpw	x, (0x09, sp)
	jrnc	00136$
00108$:
;	../mbtowc.c: 51: return(-1);
	clrw	x
	decw	x
	jp	00126$
;	../mbtowc.c: 53: for(i = 1; i < seqlen; i++)
00136$:
	ld	a, #0x01
00121$:
	cp	a, (0x0b, sp)
	jrnc	00113$
;	../mbtowc.c: 54: if((s[i] & 0xc0) != 0x80)
	clrw	x
	ld	xl, a
	addw	x, (0x05, sp)
	push	a
	ld	a, (x)
	and	a, #0xc0
	ld	xl, a
	clr	a
	ld	xh, a
	pop	a
	cpw	x, #0x0080
	jreq	00122$
;	../mbtowc.c: 55: return(-1);
	clrw	x
	decw	x
	jp	00126$
00122$:
;	../mbtowc.c: 53: for(i = 1; i < seqlen; i++)
	inc	a
	jra	00121$
00113$:
;	../mbtowc.c: 57: codepoint = first_byte;
	ld	a, (0x0c, sp)
	ld	(0x0a, sp), a
	clr	(0x09, sp)
	clrw	x
;	../mbtowc.c: 59: for(s++, i = seqlen - 1; i; i--)
	ldw	y, (0x05, sp)
	incw	y
	ldw	(0x11, sp), y
	ld	a, (0x0b, sp)
	dec	a
	ldw	y, (0x11, sp)
	ldw	(0x05, sp), y
00124$:
	tnz	a
	jreq	00114$
;	../mbtowc.c: 61: codepoint <<= 6;
	push	a
	ldw	y, (0x0a, sp)
	ld	a, #0x06
00215$:
	sllw	y
	rlcw	x
	dec	a
	jrne	00215$
	pop	a
	ldw	(0x03, sp), y
	ldw	(0x01, sp), x
;	../mbtowc.c: 62: codepoint |= (*s & 0x3f);
	ldw	x, (0x05, sp)
	push	a
	ld	a, (x)
	ld	xl, a
	pop	a
	exg	a, xl
	ld	(0x0a, sp), a
	exg	a, xl
	clr	(0x09, sp)
	push	a
	ld	a, (0x0b, sp)
	and	a, #0x3f
	ld	xl, a
	clr	a
	ld	xh, a
	pop	a
	exgw	x, y
	clrw	x
	tnzw	y
	jrpl	00217$
	decw	x
00217$:
	push	a
	ld	a, yl
	or	a, (0x05, sp)
	rlwa	y
	or	a, (0x04, sp)
	ld	yh, a
	ld	a, xl
	or	a, (0x03, sp)
	rlwa	x
	or	a, (0x02, sp)
	ld	xh, a
	pop	a
	ldw	(0x09, sp), y
;	../mbtowc.c: 63: s++;
	ldw	y, (0x05, sp)
	incw	y
	ldw	(0x05, sp), y
;	../mbtowc.c: 59: for(s++, i = seqlen - 1; i; i--)
	dec	a
	jra	00124$
00114$:
;	../mbtowc.c: 66: if(codepoint >= 0xd800 && codepoint <= 0xdfff) // UTF-16 surrogate.
	ld	a, (0x0a, sp)
	cp	a, #0x00
	ld	a, (0x09, sp)
	sbc	a, #0xd8
	ld	a, xl
	sbc	a, #0x00
	ld	a, xh
	sbc	a, #0x00
	jrc	00116$
	ld	a, #0xff
	cp	a, (0x0a, sp)
	ld	a, #0xdf
	sbc	a, (0x09, sp)
	clr	a
	pushw	x
	sbc	a, (2, sp)
	popw	x
	clr	a
	pushw	x
	sbc	a, (1, sp)
	popw	x
	jrc	00116$
;	../mbtowc.c: 67: return(-1);
	clrw	x
	decw	x
	jra	00126$
00116$:
;	../mbtowc.c: 69: if(pwc)
	ldw	y, (0x0f, sp)
	jreq	00119$
;	../mbtowc.c: 70: *pwc = codepoint;
	ldw	y, (0x0f, sp)
	ld	a, (0x0a, sp)
	ld	(0x3, y), a
	ld	a, (0x09, sp)
	ld	(0x2, y), a
	ldw	(y), x
00119$:
;	../mbtowc.c: 71: return(codepoint ? seqlen : 0);
	ldw	y, (0x09, sp)
	jrne	00221$
	tnzw	x
	jreq	00128$
00221$:
	clrw	x
	ld	a, (0x0b, sp)
	ld	xl, a
	ldw	(0x0b, sp), x
	.byte 0xbc
00128$:
	clrw	x
	ldw	(0x0b, sp), x
00129$:
	ldw	x, (0x0b, sp)
00126$:
;	../mbtowc.c: 72: }
	addw	sp, #12
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
