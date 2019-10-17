;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module sincosf
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sincosf
	.globl _fabsf
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
;	../sincosf.c: 50: float sincosf(float x, bool iscos)
;	-----------------------------------------
;	 function sincosf
;	-----------------------------------------
_sincosf:
	sub	sp, #13
;	../sincosf.c: 56: if(iscos)
	tnz	(0x15, sp)
	jreq	00105$
;	../sincosf.c: 58: y=fabsf(x)+HALF_PI;
	ldw	x, (0x13, sp)
	pushw	x
	ldw	x, (0x13, sp)
	pushw	x
	callf	_fabsf
	addw	sp, #4
	push	#0xdb
	push	#0x0f
	push	#0xc9
	push	#0x3f
	pushw	x
	pushw	y
	callf	___fsadd
	addw	sp, #8
	ldw	(0x0a, sp), x
	ldw	(0x08, sp), y
;	../sincosf.c: 59: sign=0;
	clr	(0x0d, sp)
	jra	00106$
00105$:
;	../sincosf.c: 63: if(x<0.0)
	clrw	x
	pushw	x
	clrw	x
	pushw	x
	ldw	x, (0x17, sp)
	pushw	x
	ldw	x, (0x17, sp)
	pushw	x
	callf	___fslt
	addw	sp, #8
	tnz	a
	jreq	00102$
;	../sincosf.c: 64: { y=-x; sign=1; }
	ldw	y, (0x13, sp)
	ldw	x, (0x11, sp)
	sllw	x
	ccf
	rrcw	x
	ldw	(0x0a, sp), y
	ldw	(0x08, sp), x
	ld	a, #0x01
	ld	(0x0d, sp), a
	jra	00106$
00102$:
;	../sincosf.c: 66: { y=x; sign=0; }
	ldw	y, (0x13, sp)
	ldw	(0x0a, sp), y
	ldw	y, (0x11, sp)
	ldw	(0x08, sp), y
	clr	(0x0d, sp)
00106$:
;	../sincosf.c: 69: if(y>YMAX)
	ldw	x, (0x0a, sp)
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	push	#0x00
	push	#0x0c
	push	#0x49
	push	#0x46
	callf	___fslt
	addw	sp, #8
	ld	(0x0c, sp), a
	jreq	00108$
;	../sincosf.c: 71: errno=ERANGE;
	ldw	x, #0x0022
	ldw	_errno+0, x
;	../sincosf.c: 72: return 0.0;
	clrw	x
	clrw	y
	jpf	00115$
00108$:
;	../sincosf.c: 76: N=((y*iPI)+0.5); /*y is positive*/
	ldw	x, (0x0a, sp)
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	push	#0x83
	push	#0xf9
	push	#0xa2
	push	#0x3e
	callf	___fsmul
	addw	sp, #8
	push	#0x00
	push	#0x00
	push	#0x00
	push	#0x3f
	pushw	x
	pushw	y
	callf	___fsadd
	addw	sp, #8
	pushw	x
	pushw	y
	callf	___fs2sint
	addw	sp, #4
;	../sincosf.c: 79: if(N&1) sign=!sign;
	ld	a, xl
	srl	a
	jrnc	00110$
	ld	a, (0x0d, sp)
	sub	a, #0x01
	clr	a
	rlc	a
	ld	(0x0d, sp), a
00110$:
;	../sincosf.c: 81: XN=N;
	pushw	x
	callf	___sint2fs
	addw	sp, #2
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	../sincosf.c: 83: if(iscos) XN-=0.5;
	tnz	(0x15, sp)
	jreq	00112$
	clrw	x
	pushw	x
	push	#0x00
	push	#0x3f
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	callf	___fssub
	addw	sp, #8
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
00112$:
;	../sincosf.c: 85: y=fabsf(x);
	ldw	x, (0x13, sp)
	pushw	x
	ldw	x, (0x13, sp)
	pushw	x
	callf	_fabsf
	addw	sp, #4
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
;	../sincosf.c: 86: r=(int)y;
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	callf	___fs2sint
	addw	sp, #4
	pushw	x
	callf	___sint2fs
	addw	sp, #2
	ldw	(0x0b, sp), x
	ldw	(0x09, sp), y
;	../sincosf.c: 87: g=y-r;
	ldw	x, (0x0b, sp)
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	callf	___fssub
	addw	sp, #8
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
;	../sincosf.c: 88: f=((r-XN*C1)+g)-XN*C2;
	ldw	x, (0x03, sp)
	pushw	x
	ldw	x, (0x03, sp)
	pushw	x
	clrw	x
	pushw	x
	push	#0x49
	push	#0x40
	callf	___fsmul
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x0f, sp)
	pushw	x
	ldw	x, (0x0f, sp)
	pushw	x
	callf	___fssub
	addw	sp, #8
	ldw	(0x0b, sp), x
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x0f, sp)
	pushw	x
	pushw	y
	callf	___fsadd
	addw	sp, #8
	ldw	(0x0b, sp), x
	ldw	(0x09, sp), y
	ldw	x, (0x03, sp)
	pushw	x
	ldw	x, (0x03, sp)
	pushw	x
	push	#0x22
	push	#0xaa
	push	#0x7d
	push	#0x3a
	callf	___fsmul
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x0f, sp)
	pushw	x
	ldw	x, (0x0f, sp)
	pushw	x
	callf	___fssub
	addw	sp, #8
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	../sincosf.c: 90: g=f*f;
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
;	../sincosf.c: 91: if(g>EPS2) //Used to be if(fabsf(f)>EPS)
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	push	#0xf3
	push	#0xff
	push	#0x7f
	push	#0x33
	callf	___fslt
	addw	sp, #8
	tnz	a
	jrne	00159$
	jpf	00114$
00159$:
;	../sincosf.c: 93: r=(((r4*g+r3)*g+r2)*g+r1)*g;
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	push	#0x5b
	push	#0x9c
	push	#0x2e
	push	#0x36
	callf	___fsmul
	addw	sp, #8
	push	#0x22
	push	#0xb2
	push	#0x4f
	push	#0xb9
	pushw	x
	pushw	y
	callf	___fsadd
	addw	sp, #8
	ldw	(0x0b, sp), x
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x0f, sp)
	pushw	x
	pushw	y
	callf	___fsmul
	addw	sp, #8
	push	#0x3e
	push	#0x87
	push	#0x08
	push	#0x3c
	pushw	x
	pushw	y
	callf	___fsadd
	addw	sp, #8
	ldw	(0x0b, sp), x
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x0f, sp)
	pushw	x
	pushw	y
	callf	___fsmul
	addw	sp, #8
	push	#0xa4
	push	#0xaa
	push	#0x2a
	push	#0xbe
	pushw	x
	pushw	y
	callf	___fsadd
	addw	sp, #8
	ldw	(0x0b, sp), x
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x0f, sp)
	pushw	x
	pushw	y
	callf	___fsmul
	addw	sp, #8
;	../sincosf.c: 94: f+=f*r;
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
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
00114$:
;	../sincosf.c: 96: return (sign?-f:f);
	tnz	(0x0d, sp)
	jreq	00117$
	ldw	y, (0x03, sp)
	ldw	x, (0x01, sp)
	sllw	x
	ccf
	rrcw	x
	ldw	(0x0c, sp), y
	ldw	(0x0a, sp), x
	jra	00118$
00117$:
	ldw	y, (0x03, sp)
	ldw	(0x0c, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x0a, sp), y
00118$:
	ldw	x, (0x0c, sp)
	ldw	y, (0x0a, sp)
00115$:
;	../sincosf.c: 97: }
	addw	sp, #13
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
