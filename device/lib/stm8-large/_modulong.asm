;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _modulong
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __modulong
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
;	../_modulong.c: 340: _modulong (unsigned long a, unsigned long b)
;	-----------------------------------------
;	 function _modulong
;	-----------------------------------------
__modulong:
	push	a
;	../_modulong.c: 342: unsigned char count = 0;
	clr	a
;	../_modulong.c: 344: while (!MSB_SET(b))
	clr	(0x01, sp)
00103$:
	tnz	(0x09, sp)
	jrmi	00117$
;	../_modulong.c: 346: b <<= 1;
	sll	(0x0c, sp)
	rlc	(0x0b, sp)
	rlc	(0x0a, sp)
	rlc	(0x09, sp)
;	../_modulong.c: 347: if (b > a)
	ldw	x, (0x07, sp)
	cpw	x, (0x0b, sp)
	push	a
	ld	a, (0x07, sp)
	sbc	a, (0x0b, sp)
	ld	a, (0x06, sp)
	sbc	a, (0x0a, sp)
	pop	a
	jrnc	00102$
;	../_modulong.c: 349: b >>=1;
	srl	(0x09, sp)
	rrc	(0x0a, sp)
	rrc	(0x0b, sp)
	rrc	(0x0c, sp)
;	../_modulong.c: 350: break;
	jra	00117$
00102$:
;	../_modulong.c: 352: count++;
	inc	(0x01, sp)
	ld	a, (0x01, sp)
	jra	00103$
;	../_modulong.c: 354: do
00117$:
	ld	(0x01, sp), a
00108$:
;	../_modulong.c: 356: if (a >= b)
	ldw	x, (0x07, sp)
	cpw	x, (0x0b, sp)
	ld	a, (0x06, sp)
	sbc	a, (0x0a, sp)
	ld	a, (0x05, sp)
	sbc	a, (0x09, sp)
	jrc	00107$
;	../_modulong.c: 357: a -= b;
	ldw	y, (0x07, sp)
	subw	y, (0x0b, sp)
	ld	a, (0x06, sp)
	sbc	a, (0x0a, sp)
	ld	xl, a
	ld	a, (0x05, sp)
	sbc	a, (0x09, sp)
	ld	xh, a
	ldw	(0x07, sp), y
	ldw	(0x05, sp), x
00107$:
;	../_modulong.c: 358: b >>= 1;
	srl	(0x09, sp)
	rrc	(0x0a, sp)
	rrc	(0x0b, sp)
	rrc	(0x0c, sp)
;	../_modulong.c: 360: while (count--);
	ld	a, (0x01, sp)
	dec	(0x01, sp)
	tnz	a
	jrne	00108$
;	../_modulong.c: 362: return a;
	ldw	x, (0x07, sp)
	ldw	y, (0x05, sp)
;	../_modulong.c: 363: }
	pop	a
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
