;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _fseq
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___fseq
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
;	../_fseq.c: 83: __fseq (float a1, float a2)
;	-----------------------------------------
;	 function __fseq
;	-----------------------------------------
___fseq:
	sub	sp, #16
;	../_fseq.c: 87: fl1.f = a1;
	ldw	y, (0x15, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x13, sp)
	ldw	(0x01, sp), y
;	../_fseq.c: 88: fl2.f = a2;
	ldw	y, (0x19, sp)
	ldw	(0x07, sp), y
	ldw	y, (0x17, sp)
	ldw	(0x05, sp), y
;	../_fseq.c: 90: if (fl1.l == fl2.l)
	ldw	y, (0x03, sp)
	ldw	(0x0b, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x09, sp), y
	ldw	y, (0x07, sp)
	ldw	(0x0f, sp), y
	ldw	y, (0x05, sp)
	ldw	x, (0x0b, sp)
	cpw	x, (0x0f, sp)
	jrne	00102$
	ldw	x, y
	cpw	x, (0x09, sp)
	jrne	00102$
;	../_fseq.c: 91: return (1);
	ld	a, #0x01
	jra	00105$
00102$:
;	../_fseq.c: 92: if (((fl1.l | fl2.l) & 0x7FFFFFFF) == 0)
	ldw	y, (0x03, sp)
	ldw	(0x0f, sp), y
	ldw	y, (0x01, sp)
	ldw	(0x0d, sp), y
	ldw	x, (0x07, sp)
	ldw	y, (0x05, sp)
	ld	a, xl
	or	a, (0x10, sp)
	rlwa	x
	or	a, (0x0f, sp)
	ld	xh, a
	ld	a, yl
	or	a, (0x0e, sp)
	rlwa	y
	or	a, (0x0d, sp)
	and	a, #0x7f
	ld	yh, a
	tnzw	x
	jrne	00104$
	tnzw	y
	jrne	00104$
;	../_fseq.c: 93: return (1);
	ld	a, #0x01
;	../_fseq.c: 94: return (0);
	.byte 0x21
00104$:
	clr	a
00105$:
;	../_fseq.c: 95: }
	addw	sp, #16
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
