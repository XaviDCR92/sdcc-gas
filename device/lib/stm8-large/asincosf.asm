;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module asincosf
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _asincosf
	.globl _ldexpf
	.globl _fabsf
	.globl _sqrtf
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
;	../asincosf.c: 47: float asincosf(float x, bool isacos)
;	-----------------------------------------
;	 function asincosf
;	-----------------------------------------
_asincosf:
	sub	sp, #17
;	../asincosf.c: 51: bool quartPI = isacos;
	ld	a, (0x19, sp)
	ld	(0x11, sp), a
;	../asincosf.c: 56: y = fabsf(x);
	ldw	x, (0x17, sp)
	pushw	x
	ldw	x, (0x17, sp)
	pushw	x
	callf	_fabsf
	addw	sp, #4
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	../asincosf.c: 57: if (y < EPS)
	clrw	x
	pushw	x
	push	#0x80
	push	#0x39
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	callf	___fslt
	addw	sp, #8
	ld	(0x10, sp), a
	jreq	00107$
;	../asincosf.c: 59: r = y;
	ldw	y, (0x03, sp)
	ldw	(0x0f, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x0d, sp), y
	jpf	00108$
00107$:
;	../asincosf.c: 63: if (y > 0.5)
	ldw	x, (0x03, sp)
	pushw	x
	ldw	x, (0x03, sp)
	pushw	x
	clrw	x
	pushw	x
	push	#0x00
	push	#0x3f
	callf	___fslt
	addw	sp, #8
	tnz	a
	jreq	00104$
;	../asincosf.c: 65: quartPI = !isacos;
	ld	a, (0x11, sp)
	sub	a, #0x01
	clr	a
	rlc	a
	ld	(0x11, sp), a
;	../asincosf.c: 66: if (y > 1.0)
	ldw	x, (0x03, sp)
	pushw	x
	ldw	x, (0x03, sp)
	pushw	x
	clrw	x
	pushw	x
	push	#0x80
	push	#0x3f
	callf	___fslt
	addw	sp, #8
	tnz	a
	jreq	00102$
;	../asincosf.c: 68: errno = EDOM;
	ldw	x, #0x0021
	ldw	_errno+0, x
;	../asincosf.c: 69: return 0.0;
	clrw	x
	clrw	y
	jpf	00117$
00102$:
;	../asincosf.c: 71: g = (0.5 - y) + 0.5;
	ldw	x, (0x03, sp)
	pushw	x
	ldw	x, (0x03, sp)
	pushw	x
	clrw	x
	pushw	x
	push	#0x80
	push	#0x3f
	callf	___fssub
	addw	sp, #8
;	../asincosf.c: 72: g = ldexpf(g, -1);
	push	#0xff
	push	#0xff
	pushw	x
	pushw	y
	callf	_ldexpf
	addw	sp, #6
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
;	../asincosf.c: 73: y = sqrtf(g);
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	callf	_sqrtf
	addw	sp, #4
;	../asincosf.c: 74: y = -(y + y);
	pushw	x
	pushw	y
	pushw	x
	pushw	y
	callf	___fsadd
	addw	sp, #8
	sllw	y
	ccf
	rrcw	y
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
	jra	00105$
00104$:
;	../asincosf.c: 78: g = y * y;
	ldw	x, (0x03, sp)
	pushw	x
	ldw	x, (0x03, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	callf	___fsmul
	addw	sp, #8
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
00105$:
;	../asincosf.c: 80: r = y + y * ((P(g) * g) / Q(g));
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	push	#0x65
	push	#0x20
	push	#0x01
	push	#0xbf
	callf	___fsmul
	addw	sp, #8
	push	#0x6b
	push	#0x16
	push	#0x6f
	push	#0x3f
	pushw	x
	pushw	y
	callf	___fsadd
	addw	sp, #8
	ldw	(0x0f, sp), x
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x13, sp)
	pushw	x
	pushw	y
	callf	___fsmul
	addw	sp, #8
	ldw	(0x0b, sp), x
	ldw	(0x09, sp), y
	push	#0x0b
	push	#0x8d
	push	#0xb1
	push	#0xc0
	ldw	x, (0x0b, sp)
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	callf	___fsadd
	addw	sp, #8
	ldw	(0x0f, sp), x
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x13, sp)
	pushw	x
	pushw	y
	callf	___fsmul
	addw	sp, #8
	push	#0xf0
	push	#0x50
	push	#0xb3
	push	#0x40
	pushw	x
	pushw	y
	callf	___fsadd
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x0f, sp)
	pushw	x
	ldw	x, (0x0f, sp)
	pushw	x
	callf	___fsdiv
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	callf	___fsmul
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	callf	___fsadd
	addw	sp, #8
	ldw	(0x0f, sp), x
	ldw	(0x0d, sp), y
00108$:
;	../asincosf.c: 82: i = quartPI;
	ld	a, (0x11, sp)
;	../asincosf.c: 85: if (x < 0.0)
	push	a
	clrw	x
	pushw	x
	clrw	x
	pushw	x
	ldw	x, (0x1c, sp)
	pushw	x
	ldw	x, (0x1c, sp)
	pushw	x
;	../asincosf.c: 86: r = (b[i] + r) + b[i];
	callf	___fslt
	addw	sp, #8
	ld	(0x12, sp), a
	pop	a
	exg	a, xl
	ld	a, #0x04
	exg	a, xl
	mul	x, a
	ldw	(0x0b, sp), x
;	../asincosf.c: 83: if (isacos)
	tnz	(0x19, sp)
	jrne	00152$
	jpf	00115$
00152$:
;	../asincosf.c: 85: if (x < 0.0)
	tnz	(0x11, sp)
	jreq	00110$
;	../asincosf.c: 86: r = (b[i] + r) + b[i];
	ldw	x, (0x0b, sp)
	addw	x, #(_asincosf_b_65536_26 + 0)
	clr	a
	adc	a, #((_asincosf_b_65536_26 + 0) >> 16)
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	(0x0b, sp), y
	ldw	x, (x)
	ldw	(0x09, sp), x
	pushw	y
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	callf	___fsadd
	addw	sp, #8
	ldw	(0x12, sp), x
	ldw	(0x10, sp), y
	popw	y
	ldw	y, (0x0b, sp)
	pushw	y
	ldw	y, (0x0b, sp)
	pushw	y
	ldw	x, (0x14, sp)
	pushw	x
	ldw	x, (0x14, sp)
	pushw	x
	callf	___fsadd
	addw	sp, #8
	ldw	(0x0f, sp), x
	ldw	(0x0d, sp), y
	jpf	00116$
00110$:
;	../asincosf.c: 88: r = (a[i] - r) + a[i];
	ldw	x, (0x0b, sp)
	addw	x, #(_asincosf_a_65536_26 + 0)
	clr	a
	adc	a, #((_asincosf_a_65536_26 + 0) >> 16)
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	(0x0b, sp), y
	ldw	x, (x)
	ldw	(0x09, sp), x
	pushw	y
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	callf	___fssub
	addw	sp, #8
	ldw	(0x12, sp), x
	ldw	(0x10, sp), y
	popw	y
	ldw	y, (0x0b, sp)
	pushw	y
	ldw	y, (0x0b, sp)
	pushw	y
	ldw	x, (0x14, sp)
	pushw	x
	ldw	x, (0x14, sp)
	pushw	x
	callf	___fsadd
	addw	sp, #8
	ldw	(0x0f, sp), x
	ldw	(0x0d, sp), y
	jra	00116$
00115$:
;	../asincosf.c: 92: r = (a[i] + r) + a[i];
	ldw	x, (0x0b, sp)
	addw	x, #(_asincosf_a_65536_26 + 0)
	clr	a
	adc	a, #((_asincosf_a_65536_26 + 0) >> 16)
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	(0x0b, sp), y
	ldw	x, (x)
	ldw	(0x09, sp), x
	pushw	y
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	callf	___fsadd
	addw	sp, #8
	ldw	(0x11, sp), x
	ldw	(0x0f, sp), y
	popw	y
	ldw	y, (0x0b, sp)
	pushw	y
	ldw	y, (0x0b, sp)
	pushw	y
	ldw	x, (0x13, sp)
	pushw	x
	ldw	x, (0x13, sp)
	pushw	x
	callf	___fsadd
	addw	sp, #8
	ldw	(0x0f, sp), x
	ldw	(0x0d, sp), y
;	../asincosf.c: 93: if (x < 0.0)
	tnz	(0x11, sp)
	jreq	00116$
;	../asincosf.c: 94: r = -r;
	ldw	y, (0x0f, sp)
	ldw	(0x0a, sp), y
	ld	a, (0x0e, sp)
	ld	(0x09, sp), a
	ld	a, (0x0d, sp)
	xor	a, #0x80
	ld	(0x0d, sp), a
	ldw	y, (0x0a, sp)
	ldw	(0x0f, sp), y
	ld	a, (0x09, sp)
	ld	(0x0e, sp), a
00116$:
;	../asincosf.c: 96: return r;
	ldw	x, (0x0f, sp)
	ldw	y, (0x0d, sp)
00117$:
;	../asincosf.c: 97: }
	addw	sp, #17
	retf
	.area CODE
	.area CONST
_asincosf_a_65536_26:
	.byte #0x00, #0x00, #0x00, #0x00	;  0.000000e+00
	.byte #0x3f, #0x49, #0x0f, #0xdb	;  7.853982e-01
_asincosf_b_65536_26:
	.byte #0x3f, #0xc9, #0x0f, #0xdb	;  1.570796e+00
	.byte #0x3f, #0x49, #0x0f, #0xdb	;  7.853982e-01
	.area INITIALIZER
	.area CABS (ABS)
