;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module atoi
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _atoi
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
;	../atoi.c: 34: int atoi(const char *nptr)
;	-----------------------------------------
;	 function atoi
;	-----------------------------------------
_atoi:
	sub	sp, #7
;	../atoi.c: 36: int ret = 0;
	clrw	x
	ldw	(0x04, sp), x
;	../atoi.c: 39: while (isblank (*nptr))
	ldw	y, (0x0a, sp)
00101$:
	ld	a, (y)
	ld	(0x03, sp), a
;	../atoi.c: 40: nptr++;
	ldw	x, y
	incw	x
	ldw	(0x06, sp), x
;	./../../include/ctype.h: 53: return ((unsigned char)c == ' ' || (unsigned char)c == '\t');
	cp	a, #0x20
	jreq	00115$
	cp	a, #0x09
	jrne	00131$
00115$:
;	../atoi.c: 40: nptr++;
	ldw	y, (0x06, sp)
	jra	00101$
00131$:
	ldw	(0x0a, sp), y
;	../atoi.c: 42: neg = (*nptr == '-');
	ld	a, (0x03, sp)
	sub	a, #0x2d
	jrne	00168$
	inc	a
	.byte 0x21
00168$:
	clr	a
00169$:
;	../atoi.c: 44: if (*nptr == '-' || *nptr == '+')
	ld	(0x02, sp), a
	jrne	00104$
	ld	a, (0x03, sp)
	cp	a, #0x2b
	jrne	00129$
00104$:
;	../atoi.c: 45: nptr++;
	ldw	y, (0x06, sp)
	ldw	(0x0a, sp), y
;	../atoi.c: 47: while (isdigit (*nptr))
00129$:
	ldw	y, (0x0a, sp)
	ldw	(0x06, sp), y
00107$:
	ldw	x, (0x06, sp)
	ld	a, (x)
	ld	(0x03, sp), a
;	./../../include/ctype.h: 62: return ((unsigned char)c >= '0' && (unsigned char)c <= '9');
	ld	(0x01, sp), a
	cp	a, #0x30
	jrc	00109$
	ld	a, (0x01, sp)
	cp	a, #0x39
	jrugt	00109$
;	../atoi.c: 48: ret = ret * 10 + (*(nptr++) - '0');
	ldw	x, (0x04, sp)
	sllw	x
	sllw	x
	addw	x, (0x04, sp)
	sllw	x
	ldw	(0x04, sp), x
	ldw	x, (0x06, sp)
	incw	x
	ldw	(0x06, sp), x
	clrw	x
	ld	a, (0x03, sp)
	ld	xl, a
	subw	x, #0x0030
	addw	x, (0x04, sp)
	ldw	(0x04, sp), x
	jra	00107$
00109$:
;	../atoi.c: 50: return (neg ? -ret : ret); // Since -INT_MIN is INT_MIN in sdcc, the result value always turns out ok.
	tnz	(0x02, sp)
	jreq	00120$
	ldw	x, (0x04, sp)
	negw	x
	.byte 0xc5
00120$:
	ldw	x, (0x04, sp)
00121$:
;	../atoi.c: 51: }
	addw	sp, #7
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
