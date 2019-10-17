;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module sqrtf
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _ldexpf
	.globl _frexpf
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
;	../sqrtf.c: 37: float sqrtf(float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function sqrtf
;	-----------------------------------------
_sqrtf:
	sub	sp, #10
;	../sqrtf.c: 42: if (x==0.0) return x;
	ldw	x, (0x0f, sp)
	jrne	00107$
	ldw	x, (0x0d, sp)
	sllw	x
	jrne	00107$
	ldw	x, (0x0f, sp)
	ldw	y, (0x0d, sp)
	jp	00111$
00107$:
;	../sqrtf.c: 43: else if (x==1.0) return 1.0;
	clrw	x
	pushw	x
	push	#0x80
	push	#0x3f
	ldw	x, (0x13, sp)
	pushw	x
	ldw	x, (0x13, sp)
	pushw	x
	call	___fseq
	addw	sp, #8
	tnz	a
	jreq	00104$
	clrw	x
	ldw	y, #0x3f80
	jp	00111$
00104$:
;	../sqrtf.c: 44: else if (x<0.0)
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
	tnz	a
	jreq	00108$
;	../sqrtf.c: 46: errno=EDOM;
	ldw	x, #0x0021
	ldw	_errno+0, x
;	../sqrtf.c: 47: return 0.0;
	clrw	x
	clrw	y
	jp	00111$
00108$:
;	../sqrtf.c: 49: f=frexpf(x, &n);
	ldw	x, sp
	incw	x
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	call	_frexpf
	addw	sp, #6
	ldw	(0x05, sp), x
	ldw	(0x03, sp), y
;	../sqrtf.c: 50: y=0.41731+0.59016*f; /*Educated guess*/
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	push	#0xba
	push	#0x14
	push	#0x17
	push	#0x3f
	call	___fsmul
	addw	sp, #8
	push	#0xa8
	push	#0xa9
	push	#0xd5
	push	#0x3e
	pushw	x
	pushw	y
	call	___fsadd
	addw	sp, #8
	ldw	(0x09, sp), x
	ldw	(0x07, sp), y
;	../sqrtf.c: 52: y+=f/y;
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	call	___fsdiv
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x0d, sp)
	pushw	x
	ldw	x, (0x0d, sp)
	pushw	x
	call	___fsadd
	addw	sp, #8
;	../sqrtf.c: 53: y=ldexpf(y, -2) + f/y; /*Faster version of 0.25 * y + f/y*/
	pushw	x
	pushw	y
	push	#0xfe
	push	#0xff
	pushw	x
	pushw	y
	call	_ldexpf
	addw	sp, #6
	ldw	(0x0d, sp), x
	ldw	(0x0b, sp), y
	popw	y
	pushw	y
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	call	___fsdiv
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x0d, sp)
	pushw	x
	ldw	x, (0x0d, sp)
	pushw	x
	call	___fsadd
	addw	sp, #8
	ldw	(0x09, sp), x
	ldw	(0x07, sp), y
;	../sqrtf.c: 55: if (n&1)
	ld	a, (0x02, sp)
	srl	a
	jrnc	00110$
;	../sqrtf.c: 57: y*=0.7071067812;
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	push	#0xf3
	push	#0x04
	push	#0x35
	push	#0x3f
	call	___fsmul
	addw	sp, #8
	ldw	(0x09, sp), x
	ldw	(0x07, sp), y
;	../sqrtf.c: 58: ++n;
	ldw	x, (0x01, sp)
	incw	x
	ldw	(0x01, sp), x
00110$:
;	../sqrtf.c: 60: return ldexpf(y, n/2);
	push	#0x02
	push	#0x00
	ldw	x, (0x03, sp)
	pushw	x
	call	__divsint
	addw	sp, #4
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	call	_ldexpf
	addw	sp, #6
00111$:
;	../sqrtf.c: 61: }
	addw	sp, #10
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
