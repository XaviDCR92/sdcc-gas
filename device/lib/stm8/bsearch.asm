;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module bsearch
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _bsearch
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
;	../bsearch.c: 31: void *bsearch(const void *key, const void *base, size_t nmemb, size_t size, int (*compar)(const void *, const void *) __reentrant)
;	-----------------------------------------
;	 function bsearch
;	-----------------------------------------
_bsearch:
	sub	sp, #10
;	../bsearch.c: 33: for(const char *left = base; nmemb;)
	ldw	x, (0x0f, sp)
	ldw	(0x01, sp), x
00109$:
;	../bsearch.c: 35: const char *middle = left + nmemb / 2 * size;
	ldw	x, (0x11, sp)
	jreq	00107$
	srlw	x
	ldw	(0x03, sp), x
	ldw	x, (0x13, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	call	__mulint
	addw	sp, #4
	addw	x, (0x01, sp)
;	../bsearch.c: 36: int c = (*compar)(key, middle);
	ldw	(0x05, sp), x
	ldw	(0x07, sp), x
	pushw	x
	ldw	x, (0x0f, sp)
	pushw	x
	ldw	x, (0x19, sp)
	call	(x)
	addw	sp, #4
	ldw	(0x09, sp), x
;	../bsearch.c: 38: if(c < 0)
	tnz	(0x09, sp)
	jrpl	00105$
;	../bsearch.c: 39: nmemb = nmemb / 2;	
	ldw	y, (0x03, sp)
	ldw	(0x11, sp), y
	jra	00109$
00105$:
;	../bsearch.c: 40: else if(c > 0)
	ldw	x, (0x09, sp)
	cpw	x, #0x0000
	jrsle	00102$
;	../bsearch.c: 42: left = middle + size;
	ldw	x, (0x05, sp)
	addw	x, (0x13, sp)
	ldw	(0x01, sp), x
;	../bsearch.c: 43: nmemb = (nmemb - 1) / 2;
	ldw	x, (0x11, sp)
	decw	x
	srlw	x
	ldw	(0x11, sp), x
	jra	00109$
00102$:
;	../bsearch.c: 46: return(middle);
	ldw	x, (0x07, sp)
;	../bsearch.c: 49: return(0);
	.byte 0x21
00107$:
	clrw	x
00111$:
;	../bsearch.c: 50: }
	addw	sp, #10
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
