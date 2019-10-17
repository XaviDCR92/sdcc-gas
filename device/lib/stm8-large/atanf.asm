;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module atanf
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _fabsf
	.globl _atanf
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
;	../atanf.c: 55: float atanf(float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function atanf
;	-----------------------------------------
_atanf:
	sub	sp, #14
;	../atanf.c: 58: int n=0;
	clrw	x
	ldw	(0x01, sp), x
;	../atanf.c: 61: f=fabsf(x);
	ldw	x, (0x14, sp)
	pushw	x
	ldw	x, (0x14, sp)
	pushw	x
	callf	_fabsf
	addw	sp, #4
	ldw	(0x05, sp), x
	ldw	(0x03, sp), y
;	../atanf.c: 62: if(f>1.0)
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	clrw	x
	pushw	x
	push	#0x80
	push	#0x3f
	callf	___fslt
	addw	sp, #8
	tnz	a
	jreq	00102$
;	../atanf.c: 64: f=1.0/f;
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	clrw	x
	pushw	x
	push	#0x80
	push	#0x3f
	callf	___fsdiv
	addw	sp, #8
	ldw	(0x05, sp), x
	ldw	(0x03, sp), y
;	../atanf.c: 65: n=2;
	ldw	x, #0x0002
	ldw	(0x01, sp), x
00102$:
;	../atanf.c: 67: if(f>K1)
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	push	#0xa3
	push	#0x30
	push	#0x89
	push	#0x3e
	callf	___fslt
	addw	sp, #8
	tnz	a
	jreq	00104$
;	../atanf.c: 69: f=((K2*f-1.0)+f)/(K3+f);
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	push	#0xaf
	push	#0x67
	push	#0x3b
	push	#0x3f
	callf	___fsmul
	addw	sp, #8
	push	#0x00
	push	#0x00
	push	#0x80
	push	#0x3f
	pushw	x
	pushw	y
	callf	___fssub
	addw	sp, #8
	ldw	(0x0d, sp), x
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	pushw	y
	callf	___fsadd
	addw	sp, #8
	ldw	(0x0d, sp), x
	ldw	(0x0b, sp), y
	push	#0xd7
	push	#0xb3
	push	#0xdd
	push	#0x3f
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	callf	___fsadd
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	callf	___fsdiv
	addw	sp, #8
	ldw	(0x05, sp), x
	ldw	(0x03, sp), y
;	../atanf.c: 73: n++;
	ldw	x, (0x01, sp)
	incw	x
	ldw	(0x01, sp), x
00104$:
;	../atanf.c: 75: if(fabsf(f)<EPS) r=f;
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	callf	_fabsf
	addw	sp, #4
	push	#0x00
	push	#0x00
	push	#0x80
	push	#0x39
	pushw	x
	pushw	y
	callf	___fslt
	addw	sp, #8
	ld	(0x0e, sp), a
	jreq	00106$
	ldw	y, (0x05, sp)
	ldw	(0x0d, sp), y
	ldw	y, (0x03, sp)
	ldw	(0x0b, sp), y
	jpf	00107$
00106$:
;	../atanf.c: 78: g=f*f;
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	callf	___fsmul
	addw	sp, #8
	ldw	(0x09, sp), x
	ldw	(0x07, sp), y
;	../atanf.c: 79: r=f+P(g,f)/Q(g);
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	push	#0x91
	push	#0x86
	push	#0x50
	push	#0xbd
	callf	___fsmul
	addw	sp, #8
	push	#0xf6
	push	#0x10
	push	#0xf1
	push	#0xbe
	pushw	x
	pushw	y
	callf	___fsadd
	addw	sp, #8
	ldw	(0x0d, sp), x
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	pushw	y
	callf	___fsmul
	addw	sp, #8
	ldw	(0x0d, sp), x
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	pushw	y
	callf	___fsmul
	addw	sp, #8
	ldw	(0x0d, sp), x
	ldw	(0x0b, sp), y
	push	#0xd3
	push	#0xcc
	push	#0xb4
	push	#0x3f
	ldw	x, (0x0d, sp)
	pushw	x
	ldw	x, (0x0d, sp)
	pushw	x
	callf	___fsadd
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	callf	___fsdiv
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	callf	___fsadd
	addw	sp, #8
	ldw	(0x0d, sp), x
	ldw	(0x0b, sp), y
00107$:
;	../atanf.c: 81: if(n>1) r=-r;
	ldw	x, (0x01, sp)
	cpw	x, #0x0001
	jrsle	00109$
	ldw	y, (0x0d, sp)
	ldw	x, (0x0b, sp)
	sllw	x
	ccf
	rrcw	x
	ldw	(0x0d, sp), y
	ldw	(0x0b, sp), x
00109$:
;	../atanf.c: 82: r+=a[n];
	ldw	x, (0x01, sp)
	sllw	x
	sllw	x
	addw	x, #(_atanf_a_65536_26 + 0)
	clr	a
	adc	a, #((_atanf_a_65536_26 + 0) >> 16)
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	x, (x)
	pushw	y
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	callf	___fsadd
	addw	sp, #8
;	../atanf.c: 83: if(x<0.0) r=-r;
	pushw	x
	pushw	y
	push	#0x00
	push	#0x00
	push	#0x00
	push	#0x00
	ld	a, (0x1d, sp)
	push	a
	ld	a, (0x1d, sp)
	push	a
	ld	a, (0x1d, sp)
	push	a
	ld	a, (0x1d, sp)
	push	a
	callf	___fslt
	addw	sp, #8
	popw	y
	popw	x
	tnz	a
	jreq	00111$
	sllw	y
	ccf
	rrcw	y
00111$:
;	../atanf.c: 84: return r;
;	../atanf.c: 85: }
	addw	sp, #14
	retf
	.area CODE
	.area CONST
_atanf_a_65536_26:
	.byte #0x00, #0x00, #0x00, #0x00	;  0.000000e+00
	.byte #0x3f, #0x06, #0x0a, #0x92	;  5.235988e-01
	.byte #0x3f, #0xc9, #0x0f, #0xdb	;  1.570796e+00
	.byte #0x3f, #0x86, #0x0a, #0x92	;  1.047198e+00
	.area INITIALIZER
	.area CABS (ABS)
