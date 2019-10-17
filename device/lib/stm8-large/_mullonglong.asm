;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _mullonglong
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __mullonglong
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
;	../_mullonglong.c: 35: long long _mullonglong(long long ll, long long lr)
;	-----------------------------------------
;	 function _mullonglong
;	-----------------------------------------
__mullonglong:
	sub	sp, #27
;	../_mullonglong.c: 37: unsigned long long ret = 0ull;
	clrw	x
	ldw	(0x07, sp), x
	ldw	(0x05, sp), x
	ldw	(0x03, sp), x
	ldw	(0x01, sp), x
;	../_mullonglong.c: 40: for (i = 0; i < sizeof (long long); i++)
	clr	(0x1a, sp)
00106$:
;	../_mullonglong.c: 42: unsigned char l = ll >> (i * 8);
	ld	a, (0x1a, sp)
	sll	a
	sll	a
	sll	a
	ld	(0x1b, sp), a
	ldw	y, (0x25, sp)
	ldw	(0x16, sp), y
	ldw	y, (0x23, sp)
	ldw	(0x14, sp), y
	ldw	y, (0x21, sp)
	ldw	(0x12, sp), y
	ldw	x, (0x27, sp)
	ld	a, (0x1b, sp)
	jreq	00133$
00132$:
	sra	(0x12, sp)
	rrc	(0x13, sp)
	rrc	(0x14, sp)
	rrc	(0x15, sp)
	rrc	(0x16, sp)
	rrc	(0x17, sp)
	rrcw	x
	dec	a
	jrne	00132$
00133$:
	ldw	(0x18, sp), x
	ld	a, (0x19, sp)
	ld	(0x11, sp), a
;	../_mullonglong.c: 43: for(j = 0; (i + j) < sizeof (long long); j++)
	clr	(0x1b, sp)
00104$:
	clrw	x
	ld	a, (0x1a, sp)
	ld	xl, a
	ld	a, (0x1b, sp)
	ld	(0x19, sp), a
	clr	(0x18, sp)
	addw	x, (0x18, sp)
	cpw	x, #0x0008
	jrslt	00134$
	jpf	00107$
00134$:
;	../_mullonglong.c: 45: unsigned char r = lr >> (j * 8);
	ld	a, (0x1b, sp)
	sll	a
	sll	a
	sll	a
	ld	(0x19, sp), a
	ldw	y, (0x2d, sp)
	ldw	(0x16, sp), y
	ldw	y, (0x2b, sp)
	ldw	(0x14, sp), y
	ldw	y, (0x29, sp)
	ldw	(0x12, sp), y
	ldw	x, (0x2f, sp)
	ld	a, (0x19, sp)
	jreq	00136$
00135$:
	sra	(0x12, sp)
	rrc	(0x13, sp)
	rrc	(0x14, sp)
	rrc	(0x15, sp)
	rrc	(0x16, sp)
	rrc	(0x17, sp)
	rrcw	x
	dec	a
	jrne	00135$
00136$:
	ldw	(0x18, sp), x
	ld	a, (0x19, sp)
	ld	xl, a
;	../_mullonglong.c: 46: ret += (unsigned long long)((unsigned short)(l * r)) << ((i + j) * 8);
	ld	a, (0x11, sp)
	mul	x, a
	ldw	(0x0f, sp), x
	clr	(0x0e, sp)
	clr	(0x0d, sp)
	clr	(0x0c, sp)
	clr	(0x0b, sp)
	clr	(0x0a, sp)
	clr	(0x09, sp)
	ld	a, (0x1a, sp)
	add	a, (0x1b, sp)
	sll	a
	sll	a
	sll	a
	ld	(0x19, sp), a
	ldw	y, (0x0d, sp)
	ldw	(0x16, sp), y
	ldw	y, (0x0b, sp)
	ldw	(0x14, sp), y
	ldw	y, (0x09, sp)
	ldw	(0x12, sp), y
	ldw	x, (0x0f, sp)
	ld	a, (0x19, sp)
	jreq	00138$
00137$:
	sllw	x
	rlc	(0x17, sp)
	rlc	(0x16, sp)
	rlc	(0x15, sp)
	rlc	(0x14, sp)
	rlc	(0x13, sp)
	rlc	(0x12, sp)
	dec	a
	jrne	00137$
00138$:
	ldw	(0x18, sp), x
	addw	x, (0x07, sp)
	ldw	(0x0f, sp), x
	ld	a, (0x06, sp)
	adc	a, (0x17, sp)
	ld	(0x0e, sp), a
	ld	a, (0x05, sp)
	adc	a, (0x16, sp)
	ld	(0x0d, sp), a
	ld	a, (0x04, sp)
	adc	a, (0x15, sp)
	ld	(0x0c, sp), a
	ld	a, (0x03, sp)
	adc	a, (0x14, sp)
	ldw	y, (0x01, sp)
	jrnc	00139$
	incw	y
00139$:
	addw	y, (0x12, sp)
	ld	(0x03, sp), a
	ldw	(0x01, sp), y
	ldw	y, (0x0f, sp)
	ldw	(0x07, sp), y
	ldw	y, (0x0d, sp)
	ldw	(0x05, sp), y
	ld	a, (0x0c, sp)
	ld	(0x04, sp), a
;	../_mullonglong.c: 43: for(j = 0; (i + j) < sizeof (long long); j++)
	inc	(0x1b, sp)
	jpf	00104$
00107$:
;	../_mullonglong.c: 40: for (i = 0; i < sizeof (long long); i++)
	inc	(0x1a, sp)
	ld	a, (0x1a, sp)
	cp	a, #0x08
	jrnc	00140$
	jpf	00106$
00140$:
;	../_mullonglong.c: 50: return(ret);
	ldw	x, (0x1f, sp)
	ldw	y, (0x07, sp)
	ldw	(#6, x), y
	ldw	y, (0x05, sp)
	ldw	(#4, x), y
	ldw	y, (0x03, sp)
	ldw	(#2, x), y
	ldw	y, (0x01, sp)
	ldw	(x), y
;	../_mullonglong.c: 51: }
	addw	sp, #27
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
