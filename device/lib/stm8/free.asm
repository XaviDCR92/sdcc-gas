;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module free
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _free
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
;	../free.c: 50: void free(void *ptr)
;	-----------------------------------------
;	 function free
;	-----------------------------------------
_free:
	sub	sp, #10
;	../free.c: 55: if(!ptr)
	ldw	x, (0x0d, sp)
;	../free.c: 56: return;
	jreq	00113$
;	../free.c: 58: prev_free = 0;
	clrw	x
	ldw	(0x01, sp), x
;	../free.c: 59: for(h = __sdcc_heap_free, f = &__sdcc_heap_free; h && h < ptr; prev_free = h, f = &(h->next_free), h = h->next_free); // Find adjacent blocks in free list
	ldw	x, ___sdcc_heap_free+0
	ldw	(0x09, sp), x
	ldw	x, #(___sdcc_heap_free + 0)
	ldw	(0x03, sp), x
00111$:
	ldw	x, (0x09, sp)
	jreq	00103$
	ldw	y, (0x0d, sp)
	ldw	(0x07, sp), y
	ldw	x, (0x09, sp)
	cpw	x, (0x07, sp)
	jrnc	00103$
	ldw	y, (0x09, sp)
	ldw	(0x01, sp), y
	ldw	x, (0x09, sp)
	incw	x
	incw	x
	ldw	(0x03, sp), x
	ldw	x, (x)
	ldw	(0x09, sp), x
	jra	00111$
00103$:
;	../free.c: 60: next_free = h;
	ldw	y, (0x09, sp)
	ldw	(0x05, sp), y
;	../free.c: 62: h = (void HEAPSPACE *)((char HEAPSPACE *)(ptr) - offsetof(struct header, next_free));
	ldw	x, (0x0d, sp)
	decw	x
	decw	x
;	../free.c: 65: h->next_free = next_free;
	ldw	(0x07, sp), x
	incw	x
	incw	x
	ldw	(0x09, sp), x
	ldw	y, (0x05, sp)
	ldw	(x), y
;	../free.c: 66: *f = h;
	ldw	x, (0x03, sp)
	ldw	y, (0x07, sp)
	ldw	(x), y
;	../free.c: 68: if(next_free == h->next) // Merge with next block
	ldw	x, (0x07, sp)
	ldw	x, (x)
	cpw	x, (0x05, sp)
	jrne	00105$
;	../free.c: 70: h->next_free = h->next->next_free;
	ldw	x, (0x2, x)
	ldw	y, (0x09, sp)
	ldw	(y), x
;	../free.c: 71: h->next = h->next->next;
	ldw	x, (0x07, sp)
	ldw	x, (x)
	ldw	x, (x)
	ldw	y, (0x07, sp)
	ldw	(y), x
00105$:
;	../free.c: 74: if (prev_free && prev_free->next == h) // Merge with previous block
	ldw	x, (0x01, sp)
	jreq	00113$
	ldw	x, (x)
	cpw	x, (0x07, sp)
	jrne	00113$
;	../free.c: 76: prev_free->next = h->next;
	ldw	x, (0x07, sp)
	ldw	x, (x)
	ldw	y, (0x01, sp)
	ldw	(y), x
;	../free.c: 77: prev_free->next_free = h->next_free;
	ldw	x, (0x01, sp)
	incw	x
	incw	x
	ldw	y, (0x09, sp)
	ldw	y, (y)
	ldw	(x), y
00113$:
;	../free.c: 79: }
	addw	sp, #10
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
