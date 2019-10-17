;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _itoa
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __itoa
	.globl __uitoa
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
;	../_itoa.c: 40: void _uitoa(unsigned int value, char* string, unsigned char radix)
;	-----------------------------------------
;	 function _uitoa
;	-----------------------------------------
__uitoa:
	sub	sp, #5
;	../_itoa.c: 45: do {
	clr	(0x05, sp)
00103$:
;	../_itoa.c: 46: string[index] = '0' + (value % radix);
	ld	a, (0x05, sp)
	ld	xl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xh, a
	addw	x, (0x0b, sp)
	ldw	(0x01, sp), x
	ld	a, (0x0d, sp)
	ld	(0x04, sp), a
	clr	(0x03, sp)
	ldw	x, (0x09, sp)
	ldw	y, (0x03, sp)
	divw	x, y
	ld	a, yl
	add	a, #0x30
	ldw	x, (0x01, sp)
	ld	(x), a
;	../_itoa.c: 47: if (string[index] > '9')
	ldw	x, (0x01, sp)
	ld	a, (x)
	cp	a, #0x39
	jrule	00102$
;	../_itoa.c: 48: string[index] += 'A' - '9' - 1;
	add	a, #0x07
	ldw	x, (0x01, sp)
	ld	(x), a
00102$:
;	../_itoa.c: 49: value /= radix;
	ldw	x, (0x09, sp)
	ldw	y, (0x03, sp)
	divw	x, y
	ldw	(0x09, sp), x
;	../_itoa.c: 50: ++index;
	inc	(0x05, sp)
;	../_itoa.c: 51: } while (value != 0);
	ldw	x, (0x09, sp)
	jrne	00103$
;	../_itoa.c: 54: string[index--] = '\0';
	ld	a, (0x05, sp)
	dec	a
	ld	(0x04, sp), a
	ld	a, (0x05, sp)
	ld	xl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xh, a
	addw	x, (0x0b, sp)
	clr	(x)
;	../_itoa.c: 57: while (index > i) {
	clr	(0x05, sp)
00106$:
	ld	a, (0x04, sp)
	cp	a, (0x05, sp)
	jrsle	00109$
;	../_itoa.c: 58: char tmp = string[i];
	ld	a, (0x05, sp)
	ld	xl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xh, a
	addw	x, (0x0b, sp)
	exgw	x, y
	ld	a, (y)
	ld	(0x03, sp), a
;	../_itoa.c: 59: string[i] = string[index];
	ld	a, (0x04, sp)
	ld	xl, a
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	xh, a
	addw	x, (0x0b, sp)
	ld	a, (x)
	ld	(y), a
;	../_itoa.c: 60: string[index] = tmp;
	ld	a, (0x03, sp)
	ld	(x), a
;	../_itoa.c: 61: ++i;
	inc	(0x05, sp)
;	../_itoa.c: 62: --index;
	dec	(0x04, sp)
	jra	00106$
00109$:
;	../_itoa.c: 64: }
	addw	sp, #5
	retf
;	../_itoa.c: 66: void _itoa(int value, char* string, unsigned char radix)
;	-----------------------------------------
;	 function _itoa
;	-----------------------------------------
__itoa:
;	../_itoa.c: 68: if (value < 0 && radix == 10) {
	tnz	(0x04, sp)
	jrpl	00102$
	ld	a, (0x08, sp)
	cp	a, #0x0a
	jrne	00102$
;	../_itoa.c: 69: *string++ = '-';
	ldw	x, (0x06, sp)
	ld	a, #0x2d
	ld	(x), a
	incw	x
	ldw	(0x06, sp), x
;	../_itoa.c: 70: value = -value;
	ldw	x, (0x04, sp)
	negw	x
	ldw	(0x04, sp), x
00102$:
;	../_itoa.c: 72: _uitoa(value, string, radix);
	ld	a, (0x08, sp)
	push	a
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	callf	__uitoa
	addw	sp, #5
;	../_itoa.c: 73: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
