;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module floorf
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _floorf
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
;	../floorf.c: 33: float floorf (float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function floorf
;	-----------------------------------------
_floorf:
	sub	sp, #8
;	../floorf.c: 36: r=x;
	ldw	x, (0x0d, sp)
	pushw	x
	ldw	x, (0x0d, sp)
	pushw	x
	call	___fs2slong
	addw	sp, #4
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	../floorf.c: 38: return (r+((r>x)?-1:0));
	ldw	x, (0x03, sp)
	pushw	x
	ldw	x, (0x03, sp)
	pushw	x
	call	___slong2fs
	addw	sp, #4
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
;	../floorf.c: 37: if (r<=0)
	clrw	x
	cpw	x, (0x03, sp)
	clr	a
	sbc	a, (0x02, sp)
	clr	a
	sbc	a, (0x01, sp)
	jrslt	00102$
;	../floorf.c: 38: return (r+((r>x)?-1:0));
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	call	___fslt
	addw	sp, #8
	tnz	a
	jreq	00106$
	clrw	x
	decw	x
	.byte 0x21
00106$:
	clrw	x
00107$:
	exgw	x, y
	clrw	x
	tnzw	y
	jrpl	00120$
	decw	x
00120$:
	addw	y, (0x03, sp)
	ld	a, xl
	adc	a, (0x02, sp)
	rlwa	x
	adc	a, (0x01, sp)
	ld	xh, a
	pushw	y
	pushw	x
	call	___slong2fs
	addw	sp, #4
	jra	00104$
00102$:
;	../floorf.c: 40: return r;
	ldw	x, (0x07, sp)
	ldw	y, (0x05, sp)
00104$:
;	../floorf.c: 41: }
	addw	sp, #8
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
