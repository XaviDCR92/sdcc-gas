;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _modslong
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __modslong
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
;	../_modslong.c: 259: _modslong (long a, long b)
;	-----------------------------------------
;	 function _modslong
;	-----------------------------------------
__modslong:
	sub	sp, #9
;	../_modslong.c: 263: r = (unsigned long)(a < 0 ? -a : a) % (unsigned long)(b < 0 ? -b : b);
	tnz	(0x0d, sp)
	jrmi	00125$
	clr	(0x01, sp)
	jra	00126$
00125$:
	ld	a, #0x01
	ld	(0x01, sp), a
00126$:
	tnz	(0x01, sp)
	jreq	00106$
	ldw	y, (0x0f, sp)
	negw	y
	ldw	x, (0x0d, sp)
	jrnc	00128$
	incw	x
00128$:
	negw	x
	ldw	(0x08, sp), y
	ldw	(0x06, sp), x
	jra	00107$
00106$:
	ldw	y, (0x0f, sp)
	ldw	(0x08, sp), y
	ldw	y, (0x0d, sp)
	ldw	(0x06, sp), y
00107$:
	ldw	y, (0x08, sp)
	ldw	(0x04, sp), y
	ldw	y, (0x06, sp)
	ldw	(0x02, sp), y
	tnz	(0x11, sp)
	jrpl	00108$
	ld	a, (0x14, sp)
	neg	a
	ld	(0x09, sp), a
	clr	a
	sbc	a, (0x13, sp)
	ld	(0x08, sp), a
	clr	a
	sbc	a, (0x12, sp)
	ld	(0x07, sp), a
	clr	a
	sbc	a, (0x11, sp)
	ld	(0x06, sp), a
	jra	00109$
00108$:
	ldw	y, (0x13, sp)
	ldw	(0x08, sp), y
	ldw	y, (0x11, sp)
	ldw	(0x06, sp), y
00109$:
	ldw	x, (0x08, sp)
	ldw	y, (0x06, sp)
	pushw	x
	pushw	y
	ldw	x, (0x08, sp)
	pushw	x
	ldw	x, (0x08, sp)
	pushw	x
	callf	__modulong
	addw	sp, #8
	ldw	(0x08, sp), x
	ldw	(0x06, sp), y
;	../_modslong.c: 265: if (a < 0)
	tnz	(0x01, sp)
	jreq	00102$
;	../_modslong.c: 266: return -r;
	ldw	x, (0x08, sp)
	negw	x
	ldw	y, (0x06, sp)
	jrnc	00131$
	incw	y
00131$:
	negw	y
	jra	00104$
00102$:
;	../_modslong.c: 268: return r;
	ldw	x, (0x08, sp)
	ldw	y, (0x06, sp)
00104$:
;	../_modslong.c: 269: }
	addw	sp, #9
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
