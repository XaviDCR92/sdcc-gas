;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _divsint
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __divsint
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
;	../_divsint.c: 207: _divsint (int x, int y)
;	-----------------------------------------
;	 function _divsint
;	-----------------------------------------
__divsint:
	sub	sp, #6
;	../_divsint.c: 211: r = (unsigned int)(x < 0 ? -x : x) / (unsigned int)(y < 0 ? -y : y);
	tnz	(0x0a, sp)
	jrmi	00125$
	clr	(0x01, sp)
	jra	00126$
00125$:
	ld	a, #0x01
	ld	(0x01, sp), a
00126$:
	tnz	(0x01, sp)
	jreq	00106$
	ldw	x, (0x0a, sp)
	negw	x
	.byte 0xc5
00106$:
	ldw	x, (0x0a, sp)
00107$:
	ldw	(0x02, sp), x
	tnz	(0x0c, sp)
	jrmi	00128$
	clr	(0x04, sp)
	jra	00129$
00128$:
	ld	a, #0x01
	ld	(0x04, sp), a
00129$:
	tnz	(0x04, sp)
	jreq	00108$
	ld	a, (0x0d, sp)
	neg	a
	ld	(0x06, sp), a
	clr	a
	sbc	a, (0x0c, sp)
	ld	(0x05, sp), a
	jra	00109$
00108$:
	ldw	y, (0x0c, sp)
	ldw	(0x05, sp), y
00109$:
	ldw	y, (0x05, sp)
	ldw	x, (0x02, sp)
	divw	x, y
;	../_divsint.c: 212: if ((x < 0) ^ (y < 0))
	ld	a, (0x01, sp)
	xor	a, (0x04, sp)
	jreq	00102$
;	../_divsint.c: 213: return -r;
	negw	x
;	../_divsint.c: 215: return r;
00102$:
;	../_divsint.c: 216: }
	addw	sp, #6
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
