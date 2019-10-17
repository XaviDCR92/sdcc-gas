;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module qsort
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _qsort
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
;	../qsort.c: 33: static void swap(void *restrict dst, void *restrict src, size_t n)
;	-----------------------------------------
;	 function swap
;	-----------------------------------------
_swap:
	sub	sp, #6
;	../qsort.c: 35: unsigned char *restrict d = dst;
	ldw	x, (0x0a, sp)
;	../qsort.c: 36: unsigned char *restrict s = src;
	ldw	y, (0x0c, sp)
;	../qsort.c: 38: while(n--)
	ldw	(0x03, sp), y
	ldw	y, (0x0e, sp)
	ldw	(0x05, sp), y
00101$:
	ldw	y, (0x05, sp)
	ldw	(0x01, sp), y
	ldw	y, (0x05, sp)
	decw	y
	ldw	(0x05, sp), y
	ldw	y, (0x01, sp)
	jreq	00104$
;	../qsort.c: 40: unsigned char tmp = *d;
	ld	a, (x)
	ld	(0x02, sp), a
;	../qsort.c: 41: *d = *s;
	ldw	y, (0x03, sp)
	ld	a, (y)
	ld	(x), a
;	../qsort.c: 42: *s = tmp;
	ldw	y, (0x03, sp)
	ld	a, (0x02, sp)
	ld	(y), a
;	../qsort.c: 43: d++;
	incw	x
;	../qsort.c: 44: s++;
	ldw	y, (0x03, sp)
	incw	y
	ldw	(0x03, sp), y
	jra	00101$
00104$:
;	../qsort.c: 46: }
	addw	sp, #6
	retf
;	../qsort.c: 48: void qsort(void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *) __reentrant)
;	-----------------------------------------
;	 function qsort
;	-----------------------------------------
_qsort:
	sub	sp, #12
;	../qsort.c: 50: unsigned char *b = base;
	ldw	y, (0x10, sp)
	ldw	(0x0b, sp), y
	ldw	(0x01, sp), y
;	../qsort.c: 52: if(nmemb <= 1)
	ldw	x, (0x12, sp)
	cpw	x, #0x0001
;	../qsort.c: 53: return;
	jrule	00112$
;	../qsort.c: 55: for(unsigned char *i = base; i < b + nmemb * size; i += size)
	ldw	y, (0x0b, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x14, sp)
	ldw	(0x05, sp), y
	ldw	x, y
	pushw	x
	ldw	x, (0x14, sp)
	pushw	x
	callf	__mulint
	addw	sp, #4
	addw	x, (0x01, sp)
	ldw	(0x07, sp), x
00110$:
	ldw	x, (0x03, sp)
	cpw	x, (0x07, sp)
	jrnc	00112$
;	../qsort.c: 57: for(unsigned char *j = i; (j > b) && (*compar)(j, j - size) < 0; j -= size)
	ldw	y, (0x03, sp)
00107$:
	exgw	x, y
	cpw	x, (0x01, sp)
	exgw	x, y
	jrule	00111$
	ldw	x, y
	subw	x, (0x05, sp)
	ldw	(0x09, sp), x
	ldw	(0x0b, sp), y
	pushw	x
	ldw	x, (0x0d, sp)
	pushw	x
	push	#(00147$)
	push	#(00147$ >> 8)
	push	#(00147$ >> 16)
	ldw	x, (0x1e, sp)
	pushw	x
	ld	a, (0x1f, sp)
	push	a
	retf
00147$:
	addw	sp, #4
	tnzw	x
	jrpl	00111$
;	../qsort.c: 58: swap(j, j - size, size);
	ldw	x, (0x09, sp)
	ldw	y, (0x05, sp)
	pushw	y
	pushw	x
	ldw	x, (0x0f, sp)
	pushw	x
	callf	_swap
	addw	sp, #6
;	../qsort.c: 57: for(unsigned char *j = i; (j > b) && (*compar)(j, j - size) < 0; j -= size)
	ldw	y, (0x09, sp)
	jra	00107$
00111$:
;	../qsort.c: 55: for(unsigned char *i = base; i < b + nmemb * size; i += size)
	ldw	x, (0x03, sp)
	addw	x, (0x05, sp)
	ldw	(0x03, sp), x
	jra	00110$
00112$:
;	../qsort.c: 60: }
	addw	sp, #12
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
