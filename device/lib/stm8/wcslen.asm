;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module wcslen
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _wcslen
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
;	../wcslen.c: 31: size_t wcslen(const wchar_t *s)
;	-----------------------------------------
;	 function wcslen
;	-----------------------------------------
_wcslen:
	sub	sp, #6
;	../wcslen.c: 34: while (*s)
	clrw	x
	ldw	(0x05, sp), x
	ldw	y, (0x09, sp)
00101$:
	ldw	x, y
	ld	a, (0x3, x)
	ld	(0x04, sp), a
	ld	a, (0x2, x)
	ld	(0x03, sp), a
	ldw	x, (x)
	ldw	(0x01, sp), x
	ldw	x, (0x03, sp)
	jrne	00117$
	ldw	x, (0x01, sp)
	jreq	00103$
00117$:
;	../wcslen.c: 36: n++;
	ldw	x, (0x05, sp)
	incw	x
	ldw	(0x05, sp), x
;	../wcslen.c: 37: s++;
	addw	y, #0x0004
	jra	00101$
00103$:
;	../wcslen.c: 40: return n;
	ldw	x, (0x05, sp)
;	../wcslen.c: 41: }
	addw	sp, #6
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
