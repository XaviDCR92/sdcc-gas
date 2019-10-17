;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _strncmp
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strncmp
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
;	../_strncmp.c: 31: int strncmp ( const char * first, const char * last, size_t count )
;	-----------------------------------------
;	 function strncmp
;	-----------------------------------------
_strncmp:
	sub	sp, #5
;	../_strncmp.c: 33: if (!count)
;	../_strncmp.c: 34: return(0);
	ldw	x, (0x0d, sp)
;	../_strncmp.c: 36: while (--count && *first && *first == *last) {
	jreq	00108$
	ldw	y, (0x09, sp)
	ldw	(0x02, sp), y
	ldw	y, (0x0b, sp)
	ldw	(0x04, sp), y
	ldw	y, (0x0d, sp)
00105$:
	decw	y
	ldw	x, (0x02, sp)
	ld	a, (x)
	ldw	x, (0x04, sp)
	push	a
	ld	a, (x)
	ld	(0x02, sp), a
	pop	a
	tnzw	y
	jreq	00107$
	tnz	a
	jreq	00107$
	cp	a, (0x01, sp)
	jrne	00107$
;	../_strncmp.c: 37: first++;
	ldw	x, (0x02, sp)
	incw	x
	ldw	(0x02, sp), x
;	../_strncmp.c: 38: last++;
	ldw	x, (0x04, sp)
	incw	x
	ldw	(0x04, sp), x
	jra	00105$
00107$:
;	../_strncmp.c: 41: return( *first - *last );
	clrw	x
	ld	xl, a
	ld	a, (0x01, sp)
	ld	(0x05, sp), a
	clr	(0x04, sp)
	subw	x, (0x04, sp)
00108$:
;	../_strncmp.c: 42: }
	addw	sp, #5
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
