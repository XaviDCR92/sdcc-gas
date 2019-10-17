;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module mbrtowc
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _mbrtowc
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_mbrtowc_sps_65536_10:
	.ds 3
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
;	../mbrtowc.c: 32: size_t mbrtowc(wchar_t *restrict pwc, const char *restrict s, size_t n, mbstate_t *restrict ps)
;	-----------------------------------------
;	 function mbrtowc
;	-----------------------------------------
_mbrtowc:
	sub	sp, #17
;	../mbrtowc.c: 41: if(!s)
	ldw	x, (0x16, sp)
	jrne	00102$
;	../mbrtowc.c: 42: return(mbrtowc(0, "", 1, ps));
	ldw	x, (0x1a, sp)
	pushw	x
	push	#0x01
	push	#0x00
	push	#<(___str_0 + 0)
	push	#((___str_0 + 0) >> 8)
	clrw	x
	pushw	x
	callr	_mbrtowc
	addw	sp, #8
	jp	00145$
00102$:
;	../mbrtowc.c: 43: if(!n)
	ldw	x, (0x18, sp)
	jrne	00280$
	jp	00128$
00280$:
;	../mbrtowc.c: 45: if(!ps)
	ldw	x, (0x1a, sp)
	jrne	00106$
;	../mbrtowc.c: 47: ps = &sps;
	ldw	x, #(_mbrtowc_sps_65536_10 + 0)
	ldw	(0x1a, sp), x
00106$:
;	../mbrtowc.c: 50: for(i = 0; ps->c[i] && i < 3; i++)
	ldw	x, sp
	addw	x, #3
	ldw	(0x07, sp), x
	ldw	y, (0x1a, sp)
	ldw	(0x0f, sp), y
	ldw	(0x0d, sp), y
	clr	(0x11, sp)
00131$:
	clrw	x
	ld	a, (0x11, sp)
	ld	xl, a
	addw	x, (0x0d, sp)
	ld	a, (x)
	jreq	00174$
	push	a
	ld	a, (0x12, sp)
	cp	a, #0x03
	pop	a
	jrnc	00174$
;	../mbrtowc.c: 51: mbseq[i] = ps->c[i];
	clrw	x
	exg	a, xl
	ld	a, (0x11, sp)
	exg	a, xl
	addw	x, (0x07, sp)
	ld	(x), a
;	../mbrtowc.c: 50: for(i = 0; ps->c[i] && i < 3; i++)
	inc	(0x11, sp)
	jra	00131$
00174$:
	ld	a, (0x11, sp)
	ld	(0x09, sp), a
;	../mbrtowc.c: 53: seqlen = 1;
	ld	a, #0x01
	ld	(0x0a, sp), a
;	../mbrtowc.c: 54: first_byte = ps->c[0] ? ps->c[0] : *s;
	ldw	x, (0x1a, sp)
	ld	a, (x)
	ldw	y, (0x16, sp)
	ldw	(0x0b, sp), y
	tnz	a
	jrne	00148$
	ldw	x, (0x0b, sp)
	ld	a, (x)
00148$:
;	../mbrtowc.c: 56: if(first_byte & 0x80)
	ld	(0x11, sp), a
	jrpl	00112$
;	../mbrtowc.c: 58: while (first_byte & (0x80 >> seqlen))
	ld	a, #0x01
	ld	(0x0d, sp), a
00108$:
	ldw	x, #0x0080
	ld	a, (0x0d, sp)
	jreq	00287$
00286$:
	sraw	x
	dec	a
	jrne	00286$
00287$:
	ld	a, (0x11, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
;	../mbrtowc.c: 59: seqlen++;
	ld	a, (0x0d, sp)
	inc	a
	ld	(0x0e, sp), a
;	../mbrtowc.c: 58: while (first_byte & (0x80 >> seqlen))
	ld	a, xl
	and	a, (0x02, sp)
	rlwa	x
	and	a, (0x01, sp)
	ld	xh, a
	tnzw	x
	jreq	00175$
;	../mbrtowc.c: 59: seqlen++;
	ld	a, (0x0e, sp)
	ld	(0x0d, sp), a
	jra	00108$
00175$:
	ld	a, (0x0d, sp)
	ld	(0x0a, sp), a
;	../mbrtowc.c: 60: first_byte &= (0xff >> (seqlen + 1));
	ldw	x, #0x00ff
	ld	a, (0x0e, sp)
	jreq	00290$
00289$:
	sraw	x
	dec	a
	jrne	00289$
00290$:
	ld	a, xl
	and	a, (0x11, sp)
	ld	(0x11, sp), a
00112$:
;	../mbrtowc.c: 63: if(seqlen > 4)
	ld	a, (0x0a, sp)
	cp	a, #0x04
	jrule	00291$
	jp	00128$
00291$:
;	../mbrtowc.c: 66: if(i + n < seqlen) // Incomplete multibyte character
	ld	a, (0x09, sp)
	ld	(0x0e, sp), a
	clr	(0x0d, sp)
	ldw	x, (0x0d, sp)
	addw	x, (0x18, sp)
	ld	a, (0x0a, sp)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	cpw	x, (0x01, sp)
	jrnc	00164$
;	../mbrtowc.c: 70: return(-2);
	ldw	y, (0x0f, sp)
	ldw	(0x07, sp), y
	ldw	y, (0x0b, sp)
	ldw	(0x10, sp), y
	ld	a, (0x09, sp)
	ld	(0x0f, sp), a
	ldw	y, (0x18, sp)
	ldw	(0x0d, sp), y
00134$:
;	../mbrtowc.c: 68: for(;n-- ; i++)
	ldw	x, (0x0d, sp)
	ldw	y, (0x0d, sp)
	decw	y
	ldw	(0x0d, sp), y
	tnzw	x
	jreq	00115$
;	../mbrtowc.c: 69: ps->c[i] = *s++;
	clrw	x
	ld	a, (0x0f, sp)
	ld	xl, a
	addw	x, (0x07, sp)
	ldw	y, (0x10, sp)
	ld	a, (y)
	ldw	y, (0x10, sp)
	incw	y
	ldw	(0x10, sp), y
	ld	(x), a
;	../mbrtowc.c: 68: for(;n-- ; i++)
	inc	(0x0f, sp)
	jra	00134$
00115$:
;	../mbrtowc.c: 70: return(-2);
	ldw	x, #0xfffe
	jp	00145$
;	../mbrtowc.c: 73: for(j = 0; j < i; j++)
00164$:
	clr	a
00137$:
	cp	a, (0x09, sp)
	jrnc	00118$
;	../mbrtowc.c: 74: ps->c[j] = 0;
	clrw	x
	ld	xl, a
	addw	x, (0x0f, sp)
	clr	(x)
;	../mbrtowc.c: 73: for(j = 0; j < i; j++)
	inc	a
	jra	00137$
00118$:
;	../mbrtowc.c: 76: for(n = 1, i = i ? i : 1; i < seqlen; i++, n++)
	ldw	x, #0x0001
	ldw	(0x18, sp), x
	tnz	(0x09, sp)
	jreq	00149$
	ldw	x, (0x0d, sp)
	.byte 0xc5
00149$:
	clrw	x
	incw	x
00150$:
	exg	a, xl
	ld	(0x10, sp), a
	exg	a, xl
	ldw	y, (0x07, sp)
	ldw	(0x01, sp), y
	ldw	y, (0x0b, sp)
	ldw	x, #0x0001
	ldw	(0x0e, sp), x
00140$:
	ld	a, (0x10, sp)
	cp	a, (0x0a, sp)
	jrnc	00121$
;	../mbrtowc.c: 78: mbseq[i] = *s++;
	clrw	x
	ld	a, (0x10, sp)
	ld	xl, a
	addw	x, (0x01, sp)
	ld	a, (y)
	incw	y
	ld	(x), a
;	../mbrtowc.c: 79: if((mbseq[i] & 0xc0) != 0x80)
	ld	(0x0d, sp), a
	clr	(0x0c, sp)
	ld	a, (0x0d, sp)
	and	a, #0xc0
	ld	xl, a
	clr	a
	ld	xh, a
	cpw	x, #0x0080
	jreq	00299$
	jp	00128$
00299$:
;	../mbrtowc.c: 76: for(n = 1, i = i ? i : 1; i < seqlen; i++, n++)
	inc	(0x10, sp)
	ldw	x, (0x0e, sp)
	incw	x
	ldw	(0x0e, sp), x
	ldw	(0x18, sp), x
	jra	00140$
00121$:
;	../mbrtowc.c: 83: codepoint = first_byte;
	clrw	x
	ld	a, (0x11, sp)
	ld	xl, a
	clrw	y
	ldw	(0x0f, sp), x
	ldw	(0x0d, sp), y
;	../mbrtowc.c: 85: for(s = mbseq + 1, seqlen--; seqlen; seqlen--)
	ldw	x, (0x07, sp)
	incw	x
	ld	a, (0x0a, sp)
	dec	a
	ld	(0x11, sp), a
	ldw	(0x0b, sp), x
00143$:
	tnz	(0x11, sp)
	jreq	00122$
;	../mbrtowc.c: 87: codepoint <<= 6;
	ld	a, #0x06
00302$:
	sll	(0x10, sp)
	rlc	(0x0f, sp)
	rlc	(0x0e, sp)
	rlc	(0x0d, sp)
	dec	a
	jrne	00302$
;	../mbrtowc.c: 88: codepoint |= (*s & 0x3f);
	ldw	x, (0x0b, sp)
	ld	a, (x)
	and	a, #0x3f
	ld	xl, a
	clr	a
	ld	xh, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	yl, a
	or	a, (0x0d, sp)
	ld	yh, a
	ld	a, xl
	or	a, (0x10, sp)
	rlwa	x
	or	a, (0x0f, sp)
	ld	xh, a
	ld	a, yl
	or	a, (0x0e, sp)
	ld	yl, a
	ldw	(0x0f, sp), x
	ldw	(0x0d, sp), y
;	../mbrtowc.c: 89: s++;
	ldw	x, (0x0b, sp)
	incw	x
	ldw	(0x0b, sp), x
;	../mbrtowc.c: 85: for(s = mbseq + 1, seqlen--; seqlen; seqlen--)
	dec	(0x11, sp)
	jra	00143$
00122$:
;	../mbrtowc.c: 92: if(codepoint >= 0xd800 && codepoint <= 0xdfff) // UTF-16 surrogate.
	ldw	x, (0x0f, sp)
	cpw	x, #0xd800
	ld	a, (0x0e, sp)
	sbc	a, #0x00
	ld	a, (0x0d, sp)
	sbc	a, #0x00
	jrc	00124$
	ldw	x, #0xdfff
	cpw	x, (0x0f, sp)
	clr	a
	sbc	a, (0x0e, sp)
	clr	a
	sbc	a, (0x0d, sp)
	jrc	00124$
;	../mbrtowc.c: 93: return(-1);
	clrw	x
	decw	x
	jra	00145$
00124$:
;	../mbrtowc.c: 95: if(pwc)
;	../mbrtowc.c: 96: *pwc = codepoint;
	ldw	x, (0x14, sp)
	jreq	00127$
	ldw	y, (0x0f, sp)
	ldw	(0x2, x), y
	ldw	y, (0x0d, sp)
	ldw	(x), y
00127$:
;	../mbrtowc.c: 97: return(n);
	ldw	x, (0x18, sp)
	jra	00145$
;	../mbrtowc.c: 99: eilseq:
00128$:
;	../mbrtowc.c: 100: errno = EILSEQ;
	ldw	x, #0x0054
	ldw	_errno+0, x
;	../mbrtowc.c: 101: return(-1);
	clrw	x
	decw	x
00145$:
;	../mbrtowc.c: 102: }
	addw	sp, #17
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
