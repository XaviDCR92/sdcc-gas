;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module expf
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ldexpf
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
;	../expf.c: 331: float expf(float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function expf
;	-----------------------------------------
_expf:
	sub	sp, #15
;	../expf.c: 337: if(x>=0.0)
	clrw	x
	pushw	x
	clrw	x
	pushw	x
	ldw	x, (0x19, sp)
	pushw	x
	ldw	x, (0x19, sp)
	pushw	x
	callf	___fslt
	addw	sp, #8
	tnz	a
	jrne	00102$
;	../expf.c: 338: { y=x;  sign=0; }
	ldw	y, (0x15, sp)
	ldw	(0x0e, sp), y
	ldw	y, (0x13, sp)
	ldw	(0x0c, sp), y
	clr	(0x01, sp)
	jra	00103$
00102$:
;	../expf.c: 340: { y=-x; sign=1; }
	ldw	y, (0x15, sp)
	ldw	x, (0x13, sp)
	sllw	x
	ccf
	rrcw	x
	ldw	(0x0e, sp), y
	ldw	(0x0c, sp), x
	ld	a, #0x01
	ld	(0x01, sp), a
00103$:
;	../expf.c: 342: if(y<EXPEPS) return 1.0;
	push	#0x95
	push	#0xbf
	push	#0xd6
	push	#0x33
	ldw	x, (0x12, sp)
	pushw	x
	ldw	x, (0x12, sp)
	pushw	x
	callf	___fslt
	addw	sp, #8
	ld	(0x0b, sp), a
	jreq	00105$
	clrw	x
	ldw	y, #0x3f80
	jpf	00118$
00105$:
;	../expf.c: 344: if(y>BIGX)
	ldw	x, (0x0e, sp)
	pushw	x
	ldw	x, (0x0e, sp)
	pushw	x
	push	#0x18
	push	#0x72
	push	#0xb1
	push	#0x42
	callf	___fslt
	addw	sp, #8
	tnz	a
	jreq	00110$
;	../expf.c: 346: if(sign)
	tnz	(0x01, sp)
	jreq	00107$
;	../expf.c: 348: errno=ERANGE;
	ldw	x, #0x0022
	ldw	_errno+0, x
;	../expf.c: 350: ;
	clrw	x
	decw	x
	ldw	y, #0x7f7f
	jpf	00118$
00107$:
;	../expf.c: 354: return 0.0;
	clrw	x
	clrw	y
	jpf	00118$
00110$:
;	../expf.c: 358: z=y*K1;
	ldw	x, (0x0e, sp)
	pushw	x
	ldw	x, (0x0e, sp)
	pushw	x
	push	#0x3b
	push	#0xaa
	push	#0xb8
	push	#0x3f
	callf	___fsmul
	addw	sp, #8
	ldw	(0x0a, sp), x
	ldw	(0x08, sp), y
;	../expf.c: 359: n=z;
	ldw	x, (0x0a, sp)
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	callf	___fs2sint
	addw	sp, #4
	ldw	(0x02, sp), x
;	../expf.c: 361: if(n<0) --n;
	tnz	(0x02, sp)
	jrpl	00112$
	ldw	x, (0x02, sp)
	decw	x
	ldw	(0x02, sp), x
00112$:
;	../expf.c: 362: if(z-n>=0.5) ++n;
	ldw	x, (0x02, sp)
	pushw	x
	callf	___sint2fs
	addw	sp, #2
	pushw	x
	pushw	y
	ldw	x, (0x0e, sp)
	pushw	x
	ldw	x, (0x0e, sp)
	pushw	x
	callf	___fssub
	addw	sp, #8
	push	#0x00
	push	#0x00
	push	#0x00
	push	#0x3f
	pushw	x
	pushw	y
	callf	___fslt
	addw	sp, #8
	tnz	a
	jrne	00114$
	ldw	x, (0x02, sp)
	incw	x
	ldw	(0x02, sp), x
00114$:
;	../expf.c: 363: xn=n;
	ldw	x, (0x02, sp)
	pushw	x
	callf	___sint2fs
	addw	sp, #2
	ldw	(0x0a, sp), x
	ldw	(0x08, sp), y
;	../expf.c: 364: g=((y-xn*C1))-xn*C2;
	ldw	x, (0x0a, sp)
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	push	#0x00
	push	#0x80
	push	#0x31
	push	#0x3f
	callf	___fsmul
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x12, sp)
	pushw	x
	ldw	x, (0x12, sp)
	pushw	x
	callf	___fssub
	addw	sp, #8
	ldw	(0x0e, sp), x
	ldw	(0x0c, sp), y
	ldw	x, (0x0a, sp)
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	push	#0x83
	push	#0x80
	push	#0x5e
	push	#0xb9
	callf	___fsmul
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x12, sp)
	pushw	x
	ldw	x, (0x12, sp)
	pushw	x
	callf	___fssub
	addw	sp, #8
	ldw	(0x06, sp), x
	ldw	(0x04, sp), y
;	../expf.c: 365: z=g*g;
	ldw	x, (0x06, sp)
	pushw	x
	ldw	x, (0x06, sp)
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	callf	___fsmul
	addw	sp, #8
	ldw	(0x0a, sp), x
	ldw	(0x08, sp), y
;	../expf.c: 366: r=P(z)*g;
	ldw	x, (0x0a, sp)
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	push	#0x08
	push	#0x53
	push	#0x88
	push	#0x3b
	callf	___fsmul
	addw	sp, #8
	push	#0x00
	push	#0x00
	push	#0x80
	push	#0x3e
	pushw	x
	pushw	y
	callf	___fsadd
	addw	sp, #8
	ldw	(0x0e, sp), x
	ldw	x, (0x06, sp)
	pushw	x
	ldw	x, (0x06, sp)
	pushw	x
	ldw	x, (0x12, sp)
	pushw	x
	pushw	y
	callf	___fsmul
	addw	sp, #8
	ldw	(0x0e, sp), x
	ldw	(0x0c, sp), y
;	../expf.c: 367: r=0.5+(r/(Q(z)-r));
	ldw	x, (0x0a, sp)
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	push	#0x5b
	push	#0xbf
	push	#0x4c
	push	#0x3d
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
	ldw	(0x0a, sp), x
	ldw	x, (0x0e, sp)
	pushw	x
	ldw	x, (0x0e, sp)
	pushw	x
	ldw	x, (0x0e, sp)
	pushw	x
	pushw	y
	callf	___fssub
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x12, sp)
	pushw	x
	ldw	x, (0x12, sp)
	pushw	x
	callf	___fsdiv
	addw	sp, #8
	push	#0x00
	push	#0x00
	push	#0x00
	push	#0x3f
	pushw	x
	pushw	y
	callf	___fsadd
	addw	sp, #8
	ldw	(0x0e, sp), x
;	../expf.c: 369: n++;
	ldw	x, (0x02, sp)
	incw	x
;	../expf.c: 370: z=ldexpf(r, n);
	pushw	x
	ldw	x, (0x10, sp)
	pushw	x
	pushw	y
	callf	_ldexpf
	addw	sp, #6
;	../expf.c: 371: if(sign)
	tnz	(0x01, sp)
	jreq	00116$
;	../expf.c: 372: return 1.0/z;
	pushw	x
	pushw	y
	clrw	x
	pushw	x
	push	#0x80
	push	#0x3f
	callf	___fsdiv
	addw	sp, #8
;	../expf.c: 374: return z;
00116$:
00118$:
;	../expf.c: 375: }
	addw	sp, #15
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
