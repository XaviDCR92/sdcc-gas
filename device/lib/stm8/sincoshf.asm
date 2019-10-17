;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module sincoshf
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _sincoshf
	.globl _expf
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
;	../sincoshf.c: 56: float sincoshf(float x, bool iscosh)
;	-----------------------------------------
;	 function sincoshf
;	-----------------------------------------
_sincoshf:
	sub	sp, #10
;	../sincoshf.c: 62: else { y=x;  sign=0; }
	ldw	y, (0x0f, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x0d, sp)
	ldw	(0x01, sp), y
;	../sincoshf.c: 61: if (x<0.0) { y=-x; sign=1; }
	clrw	x
	pushw	x
	clrw	x
	pushw	x
	ldw	x, (0x13, sp)
	pushw	x
	ldw	x, (0x13, sp)
	pushw	x
	call	___fslt
	addw	sp, #8
	ld	(0x0a, sp), a
	jreq	00102$
	ldw	y, (0x0f, sp)
	ldw	x, (0x0d, sp)
	sllw	x
	ccf
	rrcw	x
	ldw	(0x07, sp), y
	ldw	(0x05, sp), x
	ld	a, #0x01
	ld	(0x09, sp), a
	jra	00103$
00102$:
;	../sincoshf.c: 62: else { y=x;  sign=0; }
	ldw	y, (0x03, sp)
	ldw	(0x07, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x05, sp), y
	clr	(0x09, sp)
00103$:
;	../sincoshf.c: 64: if ((y>1.0) || iscosh)
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	clrw	x
	pushw	x
	push	#0x80
	push	#0x3f
	call	___fslt
	addw	sp, #8
	ld	(0x0a, sp), a
	jrne	00117$
	tnz	(0x11, sp)
	jrne	00160$
	jp	00118$
00160$:
00117$:
;	../sincoshf.c: 66: if(y>YBAR)
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	clrw	x
	pushw	x
	push	#0x10
	push	#0x41
	call	___fslt
	addw	sp, #8
	ld	(0x0a, sp), a
	jreq	00110$
;	../sincoshf.c: 68: w=y-K1;
	push	#0x00
	push	#0x73
	push	#0x31
	push	#0x3f
	ldw	x, (0x0b, sp)
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	call	___fssub
	addw	sp, #8
;	../sincoshf.c: 69: if (w>WMAX)
	pushw	x
	pushw	y
	pushw	x
	pushw	y
	push	#0xcf
	push	#0xbd
	push	#0x33
	push	#0x42
	call	___fslt
	addw	sp, #8
	popw	y
	popw	x
	tnz	a
	jreq	00105$
;	../sincoshf.c: 71: errno=ERANGE;
	ldw	x, #0x0022
	ldw	_errno+0, x
;	../sincoshf.c: 72: z=HUGE_VALF;
	ldw	x, #0xffff
	ldw	(0x07, sp), x
	ldw	x, #0x7f7f
	ldw	(0x05, sp), x
	jp	00111$
00105$:
;	../sincoshf.c: 76: z=expf(w);
	pushw	x
	pushw	y
	call	_expf
	addw	sp, #4
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
;	../sincoshf.c: 77: z+=K3*z;
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	push	#0x97
	push	#0x08
	push	#0x68
	push	#0x37
	call	___fsmul
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x0b, sp)
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	call	___fsadd
	addw	sp, #8
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
	jra	00111$
00110$:
;	../sincoshf.c: 82: z=expf(y);
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	call	_expf
	addw	sp, #4
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	../sincoshf.c: 83: w=1.0/z;
	ldw	x, (0x03, sp)
	pushw	x
	ldw	x, (0x03, sp)
	pushw	x
	clrw	x
	pushw	x
	push	#0x80
	push	#0x3f
	call	___fsdiv
	addw	sp, #8
	exgw	x, y
	ldw	(0x07, sp), y
;	../sincoshf.c: 84: if(!iscosh) w=-w;
	tnz	(0x11, sp)
	jrne	00108$
	ldw	y, (0x07, sp)
	sllw	x
	ccf
	rrcw	x
	ldw	(0x07, sp), y
00108$:
;	../sincoshf.c: 85: z=(z+w)*0.5;
	ldw	y, (0x07, sp)
	pushw	y
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	call	___fsadd
	addw	sp, #8
	pushw	x
	pushw	y
	clrw	x
	pushw	x
	push	#0x00
	push	#0x3f
	call	___fsmul
	addw	sp, #8
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
00111$:
;	../sincoshf.c: 87: if(sign) z=-z;
	tnz	(0x09, sp)
	jrne	00164$
	jp	00119$
00164$:
	ldw	y, (0x07, sp)
	ldw	x, (0x05, sp)
	sllw	x
	ccf
	rrcw	x
	ldw	(0x07, sp), y
	ldw	(0x05, sp), x
	jp	00119$
00118$:
;	../sincoshf.c: 91: if (y<EPS)
	clrw	x
	pushw	x
	push	#0x80
	push	#0x39
	ldw	x, (0x0b, sp)
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	call	___fslt
	addw	sp, #8
	tnz	a
	jreq	00115$
;	../sincoshf.c: 92: z=x;
	ldw	y, (0x03, sp)
	ldw	(0x07, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x05, sp), y
	jp	00119$
00115$:
;	../sincoshf.c: 95: z=x*x;
	ldw	x, (0x0f, sp)
	pushw	x
	ldw	x, (0x0f, sp)
	pushw	x
	ldw	x, (0x13, sp)
	pushw	x
	ldw	x, (0x13, sp)
	pushw	x
	call	___fsmul
	addw	sp, #8
	ldw	(0x05, sp), x
	ldw	(0x03, sp), y
;	../sincoshf.c: 96: z=x+x*z*P(z)/Q(z);
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x13, sp)
	pushw	x
	ldw	x, (0x13, sp)
	pushw	x
	call	___fsmul
	addw	sp, #8
	ldw	(0x09, sp), x
	ldw	(0x07, sp), y
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	push	#0xea
	push	#0xe6
	push	#0x42
	push	#0xbe
	call	___fsmul
	addw	sp, #8
	push	#0xf0
	push	#0x69
	push	#0xe4
	push	#0xc0
	pushw	x
	pushw	y
	call	___fsadd
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x0d, sp)
	pushw	x
	ldw	x, (0x0d, sp)
	pushw	x
	call	___fsmul
	addw	sp, #8
	ldw	(0x09, sp), x
	ldw	(0x07, sp), y
	push	#0x93
	push	#0x4f
	push	#0x2b
	push	#0xc2
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	call	___fsadd
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x0d, sp)
	pushw	x
	ldw	x, (0x0d, sp)
	pushw	x
	call	___fsdiv
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x13, sp)
	pushw	x
	ldw	x, (0x13, sp)
	pushw	x
	call	___fsadd
	addw	sp, #8
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
00119$:
;	../sincoshf.c: 99: return z;
	ldw	x, (0x07, sp)
	ldw	y, (0x05, sp)
;	../sincoshf.c: 100: }
	addw	sp, #10
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
