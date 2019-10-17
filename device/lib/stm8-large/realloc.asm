;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module realloc
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___memcpy
	.globl _memmove
	.globl _free
	.globl _malloc
	.globl _realloc
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
;	../realloc.c: 56: void *realloc(void *ptr, size_t size)
;	-----------------------------------------
;	 function realloc
;	-----------------------------------------
_realloc:
	sub	sp, #20
;	../realloc.c: 69: if(!ptr)
	ldw	x, (0x18, sp)
	jrne	00102$
;	../realloc.c: 70: return(malloc(size));
	ldw	x, (0x1a, sp)
	pushw	x
	callf	_malloc
	addw	sp, #2
	jpf	00132$
00102$:
;	../realloc.c: 72: if(!size)
	ldw	x, (0x1a, sp)
	jrne	00104$
;	../realloc.c: 74: free(ptr);
	ldw	x, (0x18, sp)
	pushw	x
	callf	_free
	addw	sp, #2
;	../realloc.c: 75: return(0);
	clrw	x
	jpf	00132$
00104$:
;	../realloc.c: 78: prev_free = 0, pf = 0;
	clrw	x
	ldw	(0x01, sp), x
	clrw	x
	ldw	(0x03, sp), x
;	../realloc.c: 79: for(h = __sdcc_heap_free, f = &__sdcc_heap_free; h && h < ptr; prev_free = h, pf = f, f = &(h->next_free), h = h->next_free); // Find adjacent blocks in free list
	ldw	x, ___sdcc_heap_free+0
	ldw	(0x13, sp), x
	ldw	x, #(___sdcc_heap_free + 0)
	ldw	(0x05, sp), x
00130$:
	ldw	x, (0x13, sp)
	jreq	00105$
	ldw	y, (0x18, sp)
	ldw	(0x11, sp), y
	ldw	x, (0x13, sp)
	cpw	x, (0x11, sp)
	jrnc	00105$
	ldw	y, (0x13, sp)
	ldw	(0x01, sp), y
	ldw	y, (0x05, sp)
	ldw	(0x03, sp), y
	ldw	x, (0x13, sp)
	incw	x
	incw	x
	ldw	(0x05, sp), x
	ldw	x, (x)
	ldw	(0x13, sp), x
	jra	00130$
00105$:
;	../realloc.c: 80: next_free = h;
	ldw	y, (0x13, sp)
	ldw	(0x07, sp), y
;	../realloc.c: 82: if(!size || size + offsetof(struct header, next_free) < size)
	ldw	x, (0x1a, sp)
	jreq	00106$
	incw	x
	incw	x
	cpw	x, (0x1a, sp)
	jrnc	00107$
00106$:
;	../realloc.c: 83: return(0);
	clrw	x
	jpf	00132$
00107$:
;	../realloc.c: 84: blocksize = size + offsetof(struct header, next_free);
;	../realloc.c: 85: if(blocksize < sizeof(struct header)) // Requiring a minimum size makes it easier to implement free(), and avoid memory leaks.
	ldw	(0x09, sp), x
	cpw	x, #0x0004
	jrnc	00110$
;	../realloc.c: 86: blocksize = sizeof(struct header);
	ldw	x, #0x0004
	ldw	(0x09, sp), x
00110$:
;	../realloc.c: 88: h = (void HEAPSPACE *)((char HEAPSPACE *)(ptr) - offsetof(struct header, next_free));
	ldw	x, (0x18, sp)
	decw	x
	decw	x
;	../realloc.c: 89: oldblocksize = (char HEAPSPACE *)(h->next) - (char HEAPSPACE *)h;
	ldw	(0x0b, sp), x
	ldw	x, (x)
	ldw	(0x0d, sp), x
	ldw	y, (0x0b, sp)
	ldw	(0x0f, sp), y
	subw	x, (0x0f, sp)
;	../realloc.c: 91: maxblocksize = oldblocksize;
	ldw	(0x11, sp), x
	ldw	(0x13, sp), x
;	../realloc.c: 92: if(prev_free && prev_free->next == h) // Can merge with previous block
	ldw	x, (0x01, sp)
	jreq	00112$
	ldw	x, (x)
	cpw	x, (0x0b, sp)
	jrne	00112$
;	../realloc.c: 93: maxblocksize += (char HEAPSPACE *)h - (char HEAPSPACE *)prev_free;
	ldw	x, (0x01, sp)
	negw	x
	addw	x, (0x0f, sp)
	addw	x, (0x11, sp)
	ldw	(0x13, sp), x
00112$:
;	../realloc.c: 94: if(next_free == h->next) // Can merge with next block
	ldw	x, (0x07, sp)
	cpw	x, (0x0d, sp)
	jrne	00115$
;	../realloc.c: 95: maxblocksize += (char HEAPSPACE *)(next_free->next) - (char HEAPSPACE *)next_free;
	ldw	x, (0x07, sp)
	ldw	x, (x)
	ldw	y, (0x07, sp)
	ldw	(0x0f, sp), y
	subw	x, (0x0f, sp)
	addw	x, (0x13, sp)
	ldw	(0x13, sp), x
00115$:
;	../realloc.c: 97: if(blocksize <= maxblocksize) // Can resize in place.
	ldw	x, (0x09, sp)
	cpw	x, (0x13, sp)
	jrule	00247$
	jpf	00125$
00247$:
;	../realloc.c: 99: if(prev_free && prev_free->next == h) // Always move into previous block to defragment
	ldw	x, (0x01, sp)
	jreq	00117$
	ldw	x, (x)
	cpw	x, (0x0b, sp)
	jrne	00117$
;	../realloc.c: 101: memmove(prev_free, h, blocksize <= oldblocksize ? blocksize : oldblocksize);
	ldw	x, (0x09, sp)
	cpw	x, (0x11, sp)
	jrugt	00134$
	ldw	y, (0x09, sp)
	ldw	(0x11, sp), y
00134$:
	ldw	y, (0x0b, sp)
	ldw	x, (0x01, sp)
	ld	a, (0x12, sp)
	push	a
	ld	a, (0x12, sp)
	push	a
	pushw	y
	pushw	x
	callf	_memmove
	addw	sp, #6
;	../realloc.c: 102: h = prev_free;
	ldw	y, (0x01, sp)
	ldw	(0x0b, sp), y
;	../realloc.c: 103: *pf = next_free;
	ldw	x, (0x03, sp)
	ldw	y, (0x07, sp)
	ldw	(x), y
;	../realloc.c: 104: f = pf;
	ldw	y, (0x03, sp)
	ldw	(0x05, sp), y
00117$:
;	../realloc.c: 107: if(next_free && next_free == h->next) // Merge with following block
	ldw	x, (0x07, sp)
	jreq	00120$
	ldw	x, (0x0b, sp)
	ldw	x, (x)
	cpw	x, (0x07, sp)
	jrne	00120$
;	../realloc.c: 109: h->next = next_free->next;
	ldw	x, (0x07, sp)
	ldw	x, (x)
	ldw	y, (0x0b, sp)
	ldw	(y), x
;	../realloc.c: 110: *f = next_free->next_free;
	ldw	x, (0x07, sp)
	ldw	x, (0x2, x)
	ldw	y, (0x05, sp)
	ldw	(y), x
00120$:
;	../realloc.c: 113: if(maxblocksize >= blocksize + sizeof(struct header)) // Create new block from free space
	ldw	x, (0x09, sp)
	addw	x, #0x0004
	ldw	(0x11, sp), x
	ldw	x, (0x13, sp)
	cpw	x, (0x11, sp)
	jrc	00123$
;	../realloc.c: 115: header_t *const newheader = (header_t *const)((char HEAPSPACE *)h + blocksize);
	ldw	x, (0x0b, sp)
	addw	x, (0x09, sp)
	ldw	(0x13, sp), x
;	../realloc.c: 116: newheader->next = h->next;
	ldw	x, (0x0b, sp)
	ldw	x, (x)
	ldw	y, (0x13, sp)
	ldw	(y), x
;	../realloc.c: 117: newheader->next_free = *f;
	ldw	x, (0x13, sp)
	incw	x
	incw	x
	ldw	y, (0x05, sp)
	ldw	y, (y)
	ldw	(x), y
;	../realloc.c: 118: *f = newheader;
	ldw	x, (0x05, sp)
	ldw	y, (0x13, sp)
	ldw	(x), y
;	../realloc.c: 119: h->next = newheader;
	ldw	x, (0x0b, sp)
	ldw	y, (0x13, sp)
	ldw	(x), y
00123$:
;	../realloc.c: 122: return(&(h->next_free));
	ldw	x, (0x0b, sp)
	incw	x
	incw	x
	jra	00132$
00125$:
;	../realloc.c: 125: if(ret = malloc(size))
	ldw	x, (0x1a, sp)
	pushw	x
	callf	_malloc
	addw	sp, #2
	ldw	(0x13, sp), x
	tnzw	x
	jreq	00127$
;	../realloc.c: 127: size_t oldsize = oldblocksize - offsetof(struct header, next_free);
	ldw	x, (0x11, sp)
	decw	x
	decw	x
;	../realloc.c: 128: memcpy(ret, ptr, size <= oldsize ? size : oldsize);
	cpw	x, (0x1a, sp)
	jrc	00136$
	ldw	x, (0x1a, sp)
00136$:
	pushw	x
	ldw	x, (0x1a, sp)
	pushw	x
	ldw	x, (0x17, sp)
	pushw	x
	callf	___memcpy
	addw	sp, #6
;	../realloc.c: 129: free(ptr);
	ldw	x, (0x18, sp)
	pushw	x
	callf	_free
	addw	sp, #2
;	../realloc.c: 130: return(ret);
	ldw	x, (0x13, sp)
;	../realloc.c: 133: return(0);
	.byte 0x21
00127$:
	clrw	x
00132$:
;	../realloc.c: 134: }
	addw	sp, #20
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
