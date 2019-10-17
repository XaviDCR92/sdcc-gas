;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module memccpy
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memccpy
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
;	../memccpy.c: 31: void *memccpy (void *restrict dst, const void *restrict src, int c, size_t n)
;	-----------------------------------------
;	 function memccpy
;	-----------------------------------------
_memccpy:
	sub	sp, #7
;	../memccpy.c: 33: char *d = dst;
	ldw	x, (0x0b, sp)
;	../memccpy.c: 34: const char *s = src;
	ldw	y, (0x0d, sp)
;	../memccpy.c: 36: while (n--)
	ldw	(0x04, sp), y
	ldw	(0x06, sp), x
	ldw	y, (0x11, sp)
00103$:
	ldw	(0x02, sp), y
	decw	y
	ldw	x, (0x02, sp)
	jreq	00105$
;	../memccpy.c: 37: if ((*d++ = *s++) == (unsigned char)c)
	ldw	x, (0x04, sp)
	ld	a, (x)
	ld	(0x01, sp), a
	ldw	x, (0x04, sp)
	incw	x
	ldw	(0x04, sp), x
	ldw	x, (0x06, sp)
	ld	a, (0x01, sp)
	ld	(x), a
	ldw	x, (0x06, sp)
	incw	x
	ldw	(0x06, sp), x
	ldw	(0x02, sp), x
	ld	a, (0x10, sp)
	cp	a, (0x01, sp)
	jrne	00103$
;	../memccpy.c: 38: return (d);
	ldw	y, (0x02, sp)
	ldw	(0x06, sp), y
	ldw	x, y
;	../memccpy.c: 40: return (0);
	.byte 0x21
00105$:
	clrw	x
00106$:
;	../memccpy.c: 41: }
	addw	sp, #7
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
