;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module wcscmp
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _wcscmp
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
;	../wcscmp.c: 31: int wcscmp(const wchar_t *s1, const wchar_t *s2)
;	-----------------------------------------
;	 function wcscmp
;	-----------------------------------------
_wcscmp:
	sub	sp, #10
;	../wcscmp.c: 33: while(*s1 == *s2 && *s1)
	ldw	y, (0x0e, sp)
	ldw	x, (0x10, sp)
	ldw	(0x09, sp), x
00102$:
	ldw	x, y
	ld	a, (0x3, x)
	ld	(0x04, sp), a
	ld	a, (0x2, x)
	ld	(0x03, sp), a
	ldw	x, (x)
	ldw	(0x01, sp), x
	ldw	x, (0x09, sp)
	ld	a, (0x3, x)
	ld	(0x08, sp), a
	ld	a, (0x2, x)
	ld	(0x07, sp), a
	ldw	x, (x)
	ldw	(0x05, sp), x
	ldw	x, (0x03, sp)
	cpw	x, (0x07, sp)
	jrne	00104$
	ldw	x, (0x01, sp)
	cpw	x, (0x05, sp)
	jrne	00104$
	ldw	x, (0x03, sp)
	jrne	00140$
	ldw	x, (0x01, sp)
	jreq	00104$
00140$:
;	../wcscmp.c: 34: s1++, s2++;
	addw	y, #0x0004
	ldw	x, (0x09, sp)
	addw	x, #0x0004
	ldw	(0x09, sp), x
	jra	00102$
00104$:
;	../wcscmp.c: 36: if(*s1 < *s2)
	ldw	x, (0x03, sp)
	cpw	x, (0x07, sp)
	ld	a, (0x02, sp)
	sbc	a, (0x06, sp)
	ld	a, (0x01, sp)
	sbc	a, (0x05, sp)
	jrnc	00106$
;	../wcscmp.c: 37: return(-1);
	clrw	x
	decw	x
	jra	00109$
00106$:
;	../wcscmp.c: 38: if(*s1 > *s2)
	ldw	x, (0x07, sp)
	cpw	x, (0x03, sp)
	ld	a, (0x06, sp)
	sbc	a, (0x02, sp)
	ld	a, (0x05, sp)
	sbc	a, (0x01, sp)
	jrnc	00108$
;	../wcscmp.c: 39: return(1);
	clrw	x
	incw	x
;	../wcscmp.c: 40: return(0);
	.byte 0x21
00108$:
	clrw	x
00109$:
;	../wcscmp.c: 41: }
	addw	sp, #10
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
