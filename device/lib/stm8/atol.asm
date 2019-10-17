;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module atol
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _atol
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
;	../atol.c: 34: long int atol(const char *nptr)
;	-----------------------------------------
;	 function atol
;	-----------------------------------------
_atol:
	sub	sp, #9
;	../atol.c: 36: long int ret = 0;
	clrw	x
	ldw	(0x03, sp), x
	ldw	(0x01, sp), x
;	../atol.c: 39: while (isblank (*nptr))
	ldw	y, (0x0c, sp)
	ldw	(0x07, sp), y
00101$:
	ldw	x, (0x07, sp)
	ld	a, (x)
	ld	(0x09, sp), a
;	../atol.c: 40: nptr++;
	ldw	x, (0x07, sp)
	incw	x
;	./../../include/ctype.h: 53: return ((unsigned char)c == ' ' || (unsigned char)c == '\t');
	cp	a, #0x20
	jreq	00115$
	cp	a, #0x09
	jrne	00131$
00115$:
;	../atol.c: 40: nptr++;
	ldw	(0x07, sp), x
	jra	00101$
00131$:
	ldw	y, (0x07, sp)
	ldw	(0x0c, sp), y
;	../atol.c: 42: neg = (*nptr == '-');
	ld	a, (0x09, sp)
	sub	a, #0x2d
	jrne	00168$
	inc	a
	.byte 0x21
00168$:
	clr	a
00169$:
;	../atol.c: 44: if (*nptr == '-' || *nptr == '+')
	ld	(0x05, sp), a
	jrne	00104$
	ld	a, (0x09, sp)
	cp	a, #0x2b
	jrne	00129$
00104$:
;	../atol.c: 45: nptr++;
	ldw	(0x0c, sp), x
;	../atol.c: 47: while (isdigit (*nptr))
00129$:
	ldw	y, (0x0c, sp)
	ldw	(0x08, sp), y
00107$:
	ldw	x, (0x08, sp)
	ld	a, (x)
	ld	(0x06, sp), a
;	./../../include/ctype.h: 62: return ((unsigned char)c >= '0' && (unsigned char)c <= '9');
	ld	(0x07, sp), a
	cp	a, #0x30
	jrc	00109$
	ld	a, (0x07, sp)
	cp	a, #0x39
	jrugt	00109$
;	../atol.c: 48: ret = ret * 10 + (*(nptr++) - '0');
	ldw	x, (0x03, sp)
	pushw	x
	ldw	x, (0x03, sp)
	pushw	x
	push	#0x0a
	clrw	x
	pushw	x
	push	#0x00
	call	__mullong
	addw	sp, #8
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
	ldw	x, (0x08, sp)
	incw	x
	ldw	(0x08, sp), x
	clrw	x
	ld	a, (0x06, sp)
	ld	xl, a
	subw	x, #0x0030
	exgw	x, y
	clrw	x
	tnzw	y
	jrpl	00177$
	decw	x
00177$:
	addw	y, (0x03, sp)
	ld	a, xl
	adc	a, (0x02, sp)
	rlwa	x
	adc	a, (0x01, sp)
	ld	xh, a
	ldw	(0x03, sp), y
	ldw	(0x01, sp), x
	jra	00107$
00109$:
;	../atol.c: 50: return (neg ? -ret : ret); // Since -LONG_MIN is LONG_MIN in sdcc, the result value always turns out ok.
	tnz	(0x05, sp)
	jreq	00120$
	ldw	y, (0x03, sp)
	negw	y
	ldw	x, (0x01, sp)
	jrnc	00179$
	incw	x
00179$:
	negw	x
	ldw	(0x08, sp), y
	ldw	(0x06, sp), x
	jra	00121$
00120$:
	ldw	y, (0x03, sp)
	ldw	(0x08, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x06, sp), y
00121$:
	ldw	x, (0x08, sp)
	ldw	y, (0x06, sp)
;	../atol.c: 51: }
	addw	sp, #9
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
