;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module mblen
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _mblen
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
;	../mblen.c: 31: int mblen(const char *s, size_t n)
;	-----------------------------------------
;	 function mblen
;	-----------------------------------------
_mblen:
	sub	sp, #5
;	../mblen.c: 36: if(!s)
;	../mblen.c: 37: return(0);
	ldw	x, (0x09, sp)
	jreq	00119$
;	../mblen.c: 39: if(!n)
;	../mblen.c: 40: return(-1);
	ldw	x, (0x0b, sp)
	jrne	00104$
	decw	x
	jra	00119$
00104$:
;	../mblen.c: 42: c = *s;
	ldw	y, (0x09, sp)
	ld	a, (y)
;	../mblen.c: 44: if(!c)
	ld	xh, a
	tnz	a
	jrne	00106$
;	../mblen.c: 45: return(0);
	clrw	x
	jra	00119$
00106$:
;	../mblen.c: 47: if(c <= 0x7f)
	ld	a, xh
	cp	a, #0x7f
	jrugt	00126$
;	../mblen.c: 48: return(1);
	clrw	x
	incw	x
	jra	00119$
;	../mblen.c: 50: while(c & 0x80)
00126$:
	clr	a
00109$:
	tnzw	x
	jrpl	00111$
;	../mblen.c: 52: c <<= 1;
	rlwa	x
	sll	a
	rrwa	x
;	../mblen.c: 53: m++;
	inc	a
	jra	00109$
00111$:
;	../mblen.c: 56: if(m > n)
	ld	(0x02, sp), a
	clr	(0x01, sp)
	ldw	x, (0x01, sp)
	cpw	x, (0x0b, sp)
	jrule	00129$
;	../mblen.c: 57: return(-1);
	clrw	x
	decw	x
	jra	00119$
;	../mblen.c: 60: while(--m)
00129$:
	ld	(0x05, sp), a
00116$:
	dec	(0x05, sp)
	tnz	(0x05, sp)
	jreq	00118$
;	../mblen.c: 61: if((*++s & 0xc0) != 0x80)
	incw	y
	ld	a, (y)
	ld	(0x04, sp), a
	clr	(0x03, sp)
	ld	a, (0x04, sp)
	and	a, #0xc0
	ld	xl, a
	clr	a
	ld	xh, a
	cpw	x, #0x0080
	jreq	00116$
;	../mblen.c: 62: return(-1);
	clrw	x
	decw	x
;	../mblen.c: 64: return(n);
	.byte 0xc5
00118$:
	ldw	x, (0x01, sp)
00119$:
;	../mblen.c: 65: }
	addw	sp, #5
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
