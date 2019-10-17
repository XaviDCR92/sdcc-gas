;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _memcmp
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memcmp
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
;	../_memcmp.c: 31: int memcmp (const void * buf1, const void * buf2, size_t count)
;	-----------------------------------------
;	 function memcmp
;	-----------------------------------------
_memcmp:
	sub	sp, #5
;	../_memcmp.c: 33: if (!count)
;	../_memcmp.c: 34: return(0);
	ldw	x, (0x0c, sp)
;	../_memcmp.c: 36: while ( --count && *((char *)buf1) == *((char *)buf2) ) {
	jreq	00107$
	ldw	y, (0x0c, sp)
	ldw	(0x04, sp), y
00104$:
	ldw	x, (0x04, sp)
	decw	x
	ldw	(0x04, sp), x
	ldw	x, (0x08, sp)
	ldw	y, (0x0a, sp)
	ldw	(0x01, sp), y
	ld	a, (x)
	ld	(0x03, sp), a
	ldw	y, (0x01, sp)
	ld	a, (y)
	ldw	y, (0x04, sp)
	jreq	00106$
	cp	a, (0x03, sp)
	jrne	00106$
;	../_memcmp.c: 37: buf1 = (char *)buf1 + 1;
	incw	x
	ldw	(0x08, sp), x
;	../_memcmp.c: 38: buf2 = (char *)buf2 + 1;
	ldw	x, (0x01, sp)
	incw	x
	ldw	(0x0a, sp), x
	jra	00104$
00106$:
;	../_memcmp.c: 41: return( *((unsigned char *)buf1) - *((unsigned char *)buf2) );
	clrw	x
	exg	a, xl
	ld	a, (0x03, sp)
	exg	a, xl
	ld	(0x05, sp), a
	clr	(0x04, sp)
	subw	x, (0x04, sp)
00107$:
;	../_memcmp.c: 42: }
	addw	sp, #5
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
