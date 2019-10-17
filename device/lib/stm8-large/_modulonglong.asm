;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _modulonglong
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __modulonglong
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
;	../_modulonglong.c: 38: _modulonglong (unsigned long long a, unsigned long long b)
;	-----------------------------------------
;	 function _modulonglong
;	-----------------------------------------
__modulonglong:
	sub	sp, #9
;	../_modulonglong.c: 40: unsigned char count = 0;
	clr	a
;	../_modulonglong.c: 42: while (!MSB_SET(b))
	clr	(0x09, sp)
00103$:
	tnz	(0x17, sp)
	jrmi	00117$
;	../_modulonglong.c: 44: b <<= 1;
	sll	(0x1e, sp)
	rlc	(0x1d, sp)
	rlc	(0x1c, sp)
	rlc	(0x1b, sp)
	rlc	(0x1a, sp)
	rlc	(0x19, sp)
	rlc	(0x18, sp)
	rlc	(0x17, sp)
;	../_modulonglong.c: 45: if (b > a)
	ldw	x, (0x15, sp)
	cpw	x, (0x1d, sp)
	push	a
	ld	a, (0x15, sp)
	sbc	a, (0x1d, sp)
	ld	a, (0x14, sp)
	sbc	a, (0x1c, sp)
	ld	a, (0x13, sp)
	sbc	a, (0x1b, sp)
	ld	a, (0x12, sp)
	sbc	a, (0x1a, sp)
	ld	a, (0x11, sp)
	sbc	a, (0x19, sp)
	ld	a, (0x10, sp)
	sbc	a, (0x18, sp)
	pop	a
	jrnc	00102$
;	../_modulonglong.c: 47: b >>=1;
	srl	(0x17, sp)
	rrc	(0x18, sp)
	rrc	(0x19, sp)
	rrc	(0x1a, sp)
	rrc	(0x1b, sp)
	rrc	(0x1c, sp)
	rrc	(0x1d, sp)
	rrc	(0x1e, sp)
;	../_modulonglong.c: 48: break;
	jra	00117$
00102$:
;	../_modulonglong.c: 50: count++;
	inc	(0x09, sp)
	ld	a, (0x09, sp)
	jra	00103$
;	../_modulonglong.c: 52: do
00117$:
	ld	(0x09, sp), a
00108$:
;	../_modulonglong.c: 54: if (a >= b)
	ldw	x, (0x15, sp)
	cpw	x, (0x1d, sp)
	ld	a, (0x14, sp)
	sbc	a, (0x1c, sp)
	ld	a, (0x13, sp)
	sbc	a, (0x1b, sp)
	ld	a, (0x12, sp)
	sbc	a, (0x1a, sp)
	ld	a, (0x11, sp)
	sbc	a, (0x19, sp)
	ld	a, (0x10, sp)
	sbc	a, (0x18, sp)
	ld	a, (0x0f, sp)
	sbc	a, (0x17, sp)
	jrc	00107$
;	../_modulonglong.c: 55: a -= b;
	ldw	x, (0x15, sp)
	subw	x, (0x1d, sp)
	ldw	(0x07, sp), x
	ld	a, (0x14, sp)
	sbc	a, (0x1c, sp)
	ld	(0x06, sp), a
	ld	a, (0x13, sp)
	sbc	a, (0x1b, sp)
	ld	(0x05, sp), a
	ld	a, (0x12, sp)
	sbc	a, (0x1a, sp)
	ld	(0x04, sp), a
	ld	a, (0x11, sp)
	sbc	a, (0x19, sp)
	ld	(0x03, sp), a
	ld	a, (0x10, sp)
	sbc	a, (0x18, sp)
	ld	(0x02, sp), a
	ld	a, (0x0f, sp)
	sbc	a, (0x17, sp)
	ld	(0x01, sp), a
	ldw	y, (0x07, sp)
	ldw	(0x15, sp), y
	ldw	y, (0x05, sp)
	ldw	(0x13, sp), y
	ldw	y, (0x03, sp)
	ldw	(0x11, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x0f, sp), y
00107$:
;	../_modulonglong.c: 56: b >>= 1;
	srl	(0x17, sp)
	rrc	(0x18, sp)
	rrc	(0x19, sp)
	rrc	(0x1a, sp)
	rrc	(0x1b, sp)
	rrc	(0x1c, sp)
	rrc	(0x1d, sp)
	rrc	(0x1e, sp)
;	../_modulonglong.c: 58: while (count--);
	ld	a, (0x09, sp)
	dec	(0x09, sp)
	tnz	a
	jrne	00108$
;	../_modulonglong.c: 60: return a;
	ldw	x, (0x0d, sp)
	ldw	y, (0x15, sp)
	ldw	(#6, x), y
	ldw	y, (0x13, sp)
	ldw	(#4, x), y
	ldw	y, (0x11, sp)
	ldw	(#2, x), y
	ldw	y, (0x0f, sp)
	ldw	(x), y
;	../_modulonglong.c: 61: }
	addw	sp, #9
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
