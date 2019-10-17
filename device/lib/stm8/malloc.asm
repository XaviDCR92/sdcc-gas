;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module malloc
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___sdcc_heap_init
	.globl ___sdcc_heap_free
	.globl _malloc
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
___sdcc_heap_free::
	.ds 2
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
;	../malloc.c: 65: void __sdcc_heap_init(void)
;	-----------------------------------------
;	 function __sdcc_heap_init
;	-----------------------------------------
___sdcc_heap_init:
;	../malloc.c: 67: __sdcc_heap_free = HEAP_START;
	ldw	x, #(___sdcc_heap + 0)
	ldw	___sdcc_heap_free+0, x
;	../malloc.c: 68: __sdcc_heap_free->next = HEAP_END;
	ldw	x, #___sdcc_heap_end+0
	ldw	[___sdcc_heap_free+0], x
;	../malloc.c: 69: __sdcc_heap_free->next_free = 0;
	ldw	x, ___sdcc_heap_free+0
	incw	x
	incw	x
	clr	(0x1, x)
	clr	(x)
;	../malloc.c: 70: }
	ret
;	../malloc.c: 75: void *malloc(size_t size)
;	-----------------------------------------
;	 function malloc
;	-----------------------------------------
_malloc:
	sub	sp, #12
;	../malloc.c: 86: if(!size || size + offsetof(struct header, next_free) < size)
	ldw	x, (0x0f, sp)
	jreq	00101$
	incw	x
	incw	x
	cpw	x, (0x0f, sp)
	jrnc	00102$
00101$:
;	../malloc.c: 87: return(0);
	clrw	x
	jra	00115$
00102$:
;	../malloc.c: 88: size += offsetof(struct header, next_free);
;	../malloc.c: 89: if(size < sizeof(struct header)) // Requiring a minimum size makes it easier to implement free(), and avoid memory leaks.
	ldw	(0x0f, sp), x
	cpw	x, #0x0004
	jrnc	00105$
;	../malloc.c: 90: size = sizeof(struct header);
	ldw	x, #0x0004
	ldw	(0x0f, sp), x
00105$:
;	../malloc.c: 92: for(h = __sdcc_heap_free, f = &__sdcc_heap_free; h; f = &(h->next_free), h = h->next_free)
	ldw	x, ___sdcc_heap_free+0
	ldw	(0x01, sp), x
	ldw	x, #(___sdcc_heap_free + 0)
	ldw	(0x03, sp), x
00113$:
;	../malloc.c: 94: size_t blocksize = (char HEAPSPACE *)(h->next) - (char HEAPSPACE *)h;
	ldw	x, (0x01, sp)
	jreq	00111$
	ldw	x, (x)
	ldw	(0x05, sp), x
	ldw	y, x
	ldw	x, (0x01, sp)
	ldw	(0x07, sp), x
	subw	y, (0x07, sp)
;	../malloc.c: 101: newheader->next_free = h->next_free;
	ldw	x, (0x01, sp)
	incw	x
	incw	x
	ldw	(0x09, sp), x
;	../malloc.c: 95: if(blocksize >= size) // Found free block of sufficient size.
	exgw	x, y
	cpw	x, (0x0f, sp)
	exgw	x, y
	jrc	00114$
;	../malloc.c: 97: if(blocksize >= size + sizeof(struct header)) // It is worth creating a new free block
	ldw	x, (0x0f, sp)
	addw	x, #0x0004
	ldw	(0x0b, sp), x
	ldw	x, y
	cpw	x, (0x0b, sp)
	jrc	00107$
;	../malloc.c: 99: header_t *const newheader = (header_t *const)((char HEAPSPACE *)h + size);
	ldw	x, (0x07, sp)
	addw	x, (0x0f, sp)
;	../malloc.c: 100: newheader->next = h->next;
	ldw	(0x0b, sp), x
	ldw	y, (0x05, sp)
	ldw	(x), y
;	../malloc.c: 101: newheader->next_free = h->next_free;
	ldw	x, (0x0b, sp)
	incw	x
	incw	x
	ldw	y, (0x09, sp)
	ldw	y, (y)
	ldw	(x), y
;	../malloc.c: 102: *f = newheader;
	ldw	x, (0x03, sp)
	ldw	y, (0x0b, sp)
	ldw	(x), y
;	../malloc.c: 103: h->next = newheader;
	ldw	x, (0x01, sp)
	ldw	y, (0x0b, sp)
	ldw	(x), y
	jra	00108$
00107$:
;	../malloc.c: 106: *f = h->next_free;
	ldw	x, (0x09, sp)
	ldw	x, (x)
	ldw	y, (0x03, sp)
	ldw	(y), x
00108$:
;	../malloc.c: 108: return(&(h->next_free));
	ldw	x, (0x09, sp)
	jra	00115$
00114$:
;	../malloc.c: 92: for(h = __sdcc_heap_free, f = &__sdcc_heap_free; h; f = &(h->next_free), h = h->next_free)
	ldw	y, (0x09, sp)
	ldw	(0x03, sp), y
	ldw	x, (0x09, sp)
	ldw	x, (x)
	ldw	(0x01, sp), x
	jra	00113$
00111$:
;	../malloc.c: 112: return(0);
	clrw	x
00115$:
;	../malloc.c: 113: }
	addw	sp, #12
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
