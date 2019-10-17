;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _memmove
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memmove
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
;	../_memmove.c: 34: void * memmove (void * dst, const void * src, size_t acount)
;	-----------------------------------------
;	 function memmove
;	-----------------------------------------
_memmove:
	sub	sp, #10
;	../_memmove.c: 36: void * ret = dst;
	ldw	y, (0x0d, sp)
	ldw	(0x03, sp), y
;	../_memmove.c: 40: if ((uintptr_t)src < (uintptr_t)dst) {
	ldw	x, (0x0f, sp)
	ldw	y, (0x0d, sp)
	ldw	(0x01, sp), y
;	../_memmove.c: 44: d = ((char *)dst)+acount-1;
	ldw	y, (0x0d, sp)
	ldw	(0x05, sp), y
;	../_memmove.c: 45: s = ((char *)src)+acount-1;
	ldw	y, (0x0f, sp)
	ldw	(0x07, sp), y
;	../_memmove.c: 46: while (acount--) {
	ldw	y, (0x11, sp)
	ldw	(0x09, sp), y
;	../_memmove.c: 40: if ((uintptr_t)src < (uintptr_t)dst) {
	cpw	x, (0x01, sp)
	jrnc	00108$
;	../_memmove.c: 44: d = ((char *)dst)+acount-1;
	ldw	x, (0x05, sp)
	addw	x, (0x11, sp)
	decw	x
	exgw	x, y
;	../_memmove.c: 45: s = ((char *)src)+acount-1;
	ldw	x, (0x07, sp)
	addw	x, (0x11, sp)
	decw	x
;	../_memmove.c: 46: while (acount--) {
	ldw	(0x05, sp), x
	ldw	(0x07, sp), y
	ldw	y, (0x09, sp)
00101$:
	ldw	x, y
	decw	y
	tnzw	x
	jreq	00109$
;	../_memmove.c: 47: *d-- = *s--;
	ldw	x, (0x05, sp)
	ld	a, (x)
	ldw	x, (0x05, sp)
	decw	x
	ldw	(0x05, sp), x
	ldw	x, (0x07, sp)
	ld	(x), a
	ldw	x, (0x07, sp)
	decw	x
	ldw	(0x07, sp), x
	jra	00101$
00108$:
;	../_memmove.c: 54: d = dst;
	ldw	x, (0x05, sp)
;	../_memmove.c: 55: s = src;
	ldw	y, (0x07, sp)
;	../_memmove.c: 56: while (acount--) {
	ldw	(0x05, sp), y
	ldw	(0x07, sp), x
00104$:
	ldw	x, (0x09, sp)
	ldw	y, (0x09, sp)
	decw	y
	ldw	(0x09, sp), y
	tnzw	x
	jreq	00109$
;	../_memmove.c: 57: *d++ = *s++;
	ldw	x, (0x05, sp)
	ld	a, (x)
	ldw	x, (0x05, sp)
	incw	x
	ldw	(0x05, sp), x
	ldw	x, (0x07, sp)
	ld	(x), a
	ldw	x, (0x07, sp)
	incw	x
	ldw	(0x07, sp), x
	jra	00104$
00109$:
;	../_memmove.c: 61: return(ret);
	ldw	x, (0x03, sp)
;	../_memmove.c: 62: }
	addw	sp, #10
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
