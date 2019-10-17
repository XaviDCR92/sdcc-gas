;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _modsint
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __modsint
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
;	../_modsint.c: 203: int _modsint (int a, int b)
;	-----------------------------------------
;	 function _modsint
;	-----------------------------------------
__modsint:
	sub	sp, #5
;	../_modsint.c: 207: r = (unsigned)(a < 0 ? -a : a) % (unsigned)(b < 0 ? -b : b);
	tnz	(0x09, sp)
	jrmi	00125$
	clr	(0x01, sp)
	jra	00126$
00125$:
	ld	a, #0x01
	ld	(0x01, sp), a
00126$:
	tnz	(0x01, sp)
	jreq	00106$
	ldw	x, (0x09, sp)
	negw	x
	.byte 0xc5
00106$:
	ldw	x, (0x09, sp)
00107$:
	ldw	(0x02, sp), x
	tnz	(0x0b, sp)
	jrpl	00108$
	ld	a, (0x0c, sp)
	neg	a
	ld	(0x05, sp), a
	clr	a
	sbc	a, (0x0b, sp)
	ld	(0x04, sp), a
	jra	00109$
00108$:
	ldw	y, (0x0b, sp)
	ldw	(0x04, sp), y
00109$:
	ldw	y, (0x04, sp)
	ldw	x, (0x02, sp)
	divw	x, y
	ldw	x, y
;	../_modsint.c: 209: if (a < 0)
	tnz	(0x01, sp)
	jreq	00102$
;	../_modsint.c: 210: return -r;
	negw	x
;	../_modsint.c: 212: return r;
00102$:
;	../_modsint.c: 213: }
	addw	sp, #5
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
