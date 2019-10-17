;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module wcstombs
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _wctomb
	.globl _wcstombs
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
;	../wcstombs.c: 33: size_t wcstombs(char *restrict s, const wchar_t *restrict pwcs, size_t n)
;	-----------------------------------------
;	 function wcstombs
;	-----------------------------------------
_wcstombs:
	sub	sp, #16
;	../wcstombs.c: 35: size_t m = 0;
	clrw	x
	ldw	(0x09, sp), x
;	../wcstombs.c: 38: while(n > MB_LEN_MAX || n >= wctomb(buffer, *pwcs))
	ldw	x, sp
	addw	x, #5
	ldw	(0x0b, sp), x
	ldw	y, (0x16, sp)
	ldw	(0x0f, sp), y
00107$:
	ldw	x, (0x18, sp)
	cpw	x, #0x0004
	jrugt	00108$
	ldw	x, (0x0f, sp)
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	(0x03, sp), y
	ldw	x, (x)
	ldw	(0x01, sp), x
	ldw	x, (0x0b, sp)
	ldw	y, (0x03, sp)
	pushw	y
	ldw	y, (0x03, sp)
	pushw	y
	pushw	x
	callf	_wctomb
	addw	sp, #6
	ldw	(0x0d, sp), x
	ldw	x, (0x18, sp)
	cpw	x, (0x0d, sp)
	jrc	00109$
00108$:
;	../wcstombs.c: 40: int b = wctomb(s, *pwcs);
	ldw	x, (0x0f, sp)
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	x, (x)
	pushw	y
	pushw	x
	ldw	x, (0x18, sp)
	pushw	x
	callf	_wctomb
	addw	sp, #6
;	../wcstombs.c: 42: if(b == 1 && !*s)
	cpw	x, #0x0001
	jrne	00102$
	ldw	y, (0x14, sp)
	ld	a, (y)
	jreq	00109$
;	../wcstombs.c: 43: break;
00102$:
;	../wcstombs.c: 44: if(b < 0)
	tnzw	x
	jrpl	00105$
;	../wcstombs.c: 45: return(-1);
	clrw	x
	decw	x
	jra	00110$
00105$:
;	../wcstombs.c: 47: n -= b;
	ldw	(0x0d, sp), x
	ldw	y, (0x18, sp)
	subw	y, (0x0d, sp)
	ldw	(0x18, sp), y
;	../wcstombs.c: 48: m += b;
	ldw	y, (0x09, sp)
	addw	y, (0x0d, sp)
	ldw	(0x09, sp), y
;	../wcstombs.c: 49: s += b;
	addw	x, (0x14, sp)
	ldw	(0x14, sp), x
;	../wcstombs.c: 50: pwcs++;
	ldw	x, (0x0f, sp)
	addw	x, #0x0004
	ldw	(0x0f, sp), x
	jra	00107$
00109$:
;	../wcstombs.c: 53: return(m);
	ldw	x, (0x09, sp)
00110$:
;	../wcstombs.c: 54: }
	addw	sp, #16
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
