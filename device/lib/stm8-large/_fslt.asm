;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _fslt
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fslt
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
;	../_fslt.c: 108: char __fslt (float a1, float a2)
;	-----------------------------------------
;	 function __fslt
;	-----------------------------------------
___fslt:
	sub	sp, #16
;	../_fslt.c: 112: fl1.f = a1;
	ldw	y, (0x16, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x14, sp)
	ldw	(0x01, sp), y
;	../_fslt.c: 113: fl2.f = a2;
	ldw	y, (0x1a, sp)
	ldw	(0x07, sp), y
	ldw	y, (0x18, sp)
	ldw	(0x05, sp), y
;	../_fslt.c: 115: if (((fl1.l | fl2.l) & 0x7FFFFFFF) == 0)
	ldw	y, (0x03, sp)
	ldw	(0x0f, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x0d, sp), y
	ldw	x, (0x07, sp)
	ldw	y, (0x05, sp)
	ld	a, xl
	or	a, (0x10, sp)
	ld	(0x0c, sp), a
	ld	a, xh
	or	a, (0x0f, sp)
	ld	(0x0b, sp), a
	ld	a, yl
	or	a, (0x0e, sp)
	ld	(0x0a, sp), a
	ld	a, yh
	or	a, (0x0d, sp)
	and	a, #0x7f
	ld	(0x0d, sp), a
	ldw	y, (0x0b, sp)
	ldw	(0x0f, sp), y
	ld	a, (0x0a, sp)
	ld	(0x0e, sp), a
	ldw	x, (0x0f, sp)
	jrne	00102$
	ldw	x, (0x0d, sp)
	jrne	00102$
;	../_fslt.c: 116: return (0);
	clr	a
	jra	00110$
00102$:
;	../_fslt.c: 118: if (fl1.l<0 && fl2.l<0) {
	ldw	y, (0x03, sp)
	ldw	(0x0f, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x0d, sp), y
	tnz	(0x0d, sp)
	jrpl	00106$
	ldw	y, (0x07, sp)
	ldw	(0x0f, sp), y
	ldw	y, (0x05, sp)
	ldw	(0x0d, sp), y
	tnz	(0x0d, sp)
	jrpl	00106$
;	../_fslt.c: 119: if (fl2.l < fl1.l)
	ldw	y, (0x07, sp)
	ldw	(0x0b, sp), y
	ldw	y, (0x05, sp)
	ldw	(0x09, sp), y
	ldw	y, (0x03, sp)
	ldw	(0x0f, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x0d, sp), y
	ldw	x, (0x0b, sp)
	cpw	x, (0x0f, sp)
	ld	a, (0x0a, sp)
	sbc	a, (0x0e, sp)
	ld	a, (0x09, sp)
	sbc	a, (0x0d, sp)
	jrsge	00104$
;	../_fslt.c: 120: return (1);
	ld	a, #0x01
	jra	00110$
00104$:
;	../_fslt.c: 121: return (0);
	clr	a
	jra	00110$
00106$:
;	../_fslt.c: 124: if (fl1.l < fl2.l)
	ldw	y, (0x03, sp)
	ldw	(0x0b, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x09, sp), y
	ldw	y, (0x07, sp)
	ldw	(0x0f, sp), y
	ldw	y, (0x05, sp)
	ldw	(0x0d, sp), y
	ldw	x, (0x0b, sp)
	cpw	x, (0x0f, sp)
	ld	a, (0x0a, sp)
	sbc	a, (0x0e, sp)
	ld	a, (0x09, sp)
	sbc	a, (0x0d, sp)
	jrsge	00109$
;	../_fslt.c: 125: return (1);
	ld	a, #0x01
;	../_fslt.c: 126: return (0);
	.byte 0x21
00109$:
	clr	a
00110$:
;	../_fslt.c: 127: }
	addw	sp, #16
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
