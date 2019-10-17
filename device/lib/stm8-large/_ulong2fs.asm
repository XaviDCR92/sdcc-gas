;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _ulong2fs
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___ulong2fs
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
;	../_ulong2fs.c: 83: float __ulong2fs (unsigned long a )
;	-----------------------------------------
;	 function __ulong2fs
;	-----------------------------------------
___ulong2fs:
	sub	sp, #8
;	../_ulong2fs.c: 88: if (!a)
	ldw	x, (0x0e, sp)
	jrne	00115$
;	../_ulong2fs.c: 90: return 0.0;
	ldw	x, (0x0c, sp)
	jrne	00115$
	clrw	y
	jra	00111$
;	../_ulong2fs.c: 93: while (a < HIDDEN)
00115$:
	ld	a, #0x96
00103$:
	ldw	x, (0x0c, sp)
	cpw	x, #0x0080
	jrnc	00118$
;	../_ulong2fs.c: 95: a <<= 1;
	sll	(0x0f, sp)
	rlc	(0x0e, sp)
	rlc	(0x0d, sp)
	rlc	(0x0c, sp)
;	../_ulong2fs.c: 96: exp--;
	dec	a
	jra	00103$
;	../_ulong2fs.c: 99: while (a & NORM) 
00118$:
00108$:
	tnz	(0x0c, sp)
	jreq	00110$
;	../_ulong2fs.c: 102: if (a & 1)
	push	a
	ld	a, (0x10, sp)
	srl	a
	pop	a
	jrnc	00107$
;	../_ulong2fs.c: 103: a += 2;
	ldw	x, (0x0e, sp)
	addw	x, #0x0002
	ldw	y, (0x0c, sp)
	jrnc	00150$
	incw	y
00150$:
	ldw	(0x0e, sp), x
	ldw	(0x0c, sp), y
00107$:
;	../_ulong2fs.c: 104: a >>= 1;
	srl	(0x0c, sp)
	rrc	(0x0d, sp)
	rrc	(0x0e, sp)
	rrc	(0x0f, sp)
;	../_ulong2fs.c: 105: exp++;
	inc	a
	jra	00108$
00110$:
;	../_ulong2fs.c: 108: a &= ~HIDDEN ;
	push	a
	ldw	y, (0x0f, sp)
	ld	a, (0x0e, sp)
	and	a, #0x7f
	ld	xl, a
	ld	a, (0x0d, sp)
	ld	xh, a
	pop	a
	ldw	(0x0e, sp), y
	ldw	(0x0c, sp), x
;	../_ulong2fs.c: 110: fl.l = PACK(0,(unsigned long)exp, a);
	clrw	x
	ld	xl, a
	clr	(0x08, sp)
	clr	(0x07, sp)
	ld	a, #0x07
00151$:
	sllw	x
	dec	a
	jrne	00151$
	ld	a, (0x08, sp)
	or	a, (0x0f, sp)
	ld	yl, a
	ld	a, (0x07, sp)
	or	a, (0x0e, sp)
	ld	yh, a
	ld	a, xl
	or	a, (0x0d, sp)
	rlwa	x
	or	a, (0x0c, sp)
	ld	xh, a
	ldw	(0x03, sp), y
	ldw	(0x01, sp), x
;	../_ulong2fs.c: 112: return (fl.f);
	ldw	x, (0x03, sp)
	ldw	y, (0x01, sp)
00111$:
;	../_ulong2fs.c: 113: }
	addw	sp, #8
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
