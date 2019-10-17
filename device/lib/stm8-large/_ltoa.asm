;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _ltoa
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __ltoa
	.globl __ultoa
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
;	../_ltoa.c: 56: void _ultoa(unsigned long value, char* string, unsigned char radix)
;	-----------------------------------------
;	 function _ultoa
;	-----------------------------------------
__ultoa:
	sub	sp, #39
;	../_ltoa.c: 61: do {
	ldw	x, sp
	addw	x, #5
	ldw	(0x25, sp), x
	ld	a, #0x20
	ld	(0x27, sp), a
00103$:
;	../_ltoa.c: 62: unsigned char c = '0' + (value % radix);
	ld	a, (0x31, sp)
	ld	(0x04, sp), a
	clr	(0x03, sp)
	clr	(0x02, sp)
	clr	(0x01, sp)
	ldw	x, (0x03, sp)
	pushw	x
	ldw	x, (0x03, sp)
	pushw	x
	ldw	x, (0x31, sp)
	pushw	x
	ldw	x, (0x31, sp)
	pushw	x
	callf	__modulong
	addw	sp, #8
	ld	a, xl
	add	a, #0x30
;	../_ltoa.c: 63: if (c > (unsigned char)'9')
	cp	a, #0x39
	jrule	00102$
;	../_ltoa.c: 64: c += 'A' - '9' - 1;
	add	a, #0x07
00102$:
;	../_ltoa.c: 65: buffer[--index] = c;
	dec	(0x27, sp)
	clrw	x
	exg	a, xl
	ld	a, (0x27, sp)
	exg	a, xl
	addw	x, (0x25, sp)
	ld	(x), a
;	../_ltoa.c: 66: value /= radix;
	ldw	x, (0x03, sp)
	pushw	x
	ldw	x, (0x03, sp)
	pushw	x
	ldw	x, (0x31, sp)
	pushw	x
	ldw	x, (0x31, sp)
	pushw	x
	callf	__divulong
	addw	sp, #8
	ldw	(0x2d, sp), x
	ldw	(0x2b, sp), y
;	../_ltoa.c: 67: } while (value);
	ldw	x, (0x2d, sp)
	jrne	00103$
	ldw	x, (0x2b, sp)
	jrne	00103$
;	../_ltoa.c: 69: do {
	ldw	x, (0x2f, sp)
00106$:
;	../_ltoa.c: 70: *string++ = buffer[index];
	clrw	y
	ld	a, (0x27, sp)
	ld	yl, a
	addw	y, (0x25, sp)
	ld	a, (y)
	ld	(x), a
	incw	x
;	../_ltoa.c: 71: } while ( ++index != NUMBER_OF_DIGITS );
	inc	(0x27, sp)
	ld	a, (0x27, sp)
	cp	a, #0x20
	jrne	00106$
;	../_ltoa.c: 73: *string = 0;  /* string terminator */
	clr	(x)
;	../_ltoa.c: 74: }
	addw	sp, #39
	retf
;	../_ltoa.c: 76: void _ltoa(long value, char* string, unsigned char radix)
;	-----------------------------------------
;	 function _ltoa
;	-----------------------------------------
__ltoa:
;	../_ltoa.c: 78: if (value < 0 && radix == 10) {
	tnz	(0x04, sp)
	jrpl	00102$
	ld	a, (0x0a, sp)
	cp	a, #0x0a
	jrne	00102$
;	../_ltoa.c: 79: *string++ = '-';
	ldw	x, (0x08, sp)
	ld	a, #0x2d
	ld	(x), a
	incw	x
	ldw	(0x08, sp), x
;	../_ltoa.c: 80: value = -value;
	ldw	y, (0x06, sp)
	negw	y
	ldw	x, (0x04, sp)
	jrnc	00120$
	incw	x
00120$:
	negw	x
	ldw	(0x06, sp), y
	ldw	(0x04, sp), x
00102$:
;	../_ltoa.c: 82: _ultoa(value, string, radix);
	ld	a, (0x0a, sp)
	push	a
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	callf	__ultoa
	addw	sp, #7
;	../_ltoa.c: 83: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
