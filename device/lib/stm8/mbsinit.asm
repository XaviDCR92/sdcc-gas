;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module mbsinit
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _mbsinit
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
;	../mbsinit.c: 31: int mbsinit(const mbstate_t *ps)
;	-----------------------------------------
;	 function mbsinit
;	-----------------------------------------
_mbsinit:
;	../mbsinit.c: 33: return(!ps || !ps->c[0] && !ps->c[1] && !ps->c[2]);
	ldw	x, (0x03, sp)
	jreq	00104$
	ld	a, (x)
	jrne	00103$
	ldw	y, x
	ld	a, (0x1, y)
	jrne	00103$
	ld	a, (0x2, x)
	jreq	00104$
00103$:
	clr	a
	.byte 0xc5
00104$:
	ld	a, #0x01
00105$:
	clrw	x
	ld	xl, a
;	../mbsinit.c: 34: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
