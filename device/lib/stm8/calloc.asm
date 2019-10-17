;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module calloc
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _memset
	.globl _malloc
	.globl _calloc
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
;	../calloc.c: 44: void *calloc (size_t nmemb, size_t size)
;	-----------------------------------------
;	 function calloc
;	-----------------------------------------
_calloc:
	sub	sp, #6
;	../calloc.c: 49: unsigned long msize = (unsigned long)nmemb * (unsigned long)size;
	ldw	x, (0x09, sp)
	ldw	y, (0x0b, sp)
	pushw	y
	pushw	x
	call	___muluint2ulong
	addw	sp, #4
	ldw	(0x05, sp), x
;	../calloc.c: 54: if (msize > SIZE_MAX)
	ldw	(0x03, sp), y
	ldw	x, y
	jreq	00102$
;	../calloc.c: 55: return(0);
	clrw	x
	jra	00105$
00102$:
;	../calloc.c: 57: if (ptr = malloc(msize))
	ldw	y, (0x05, sp)
	ldw	(0x01, sp), y
	ldw	x, y
	pushw	x
	call	_malloc
	addw	sp, #2
	ldw	(0x03, sp), x
	ldw	(0x05, sp), x
	ldw	x, (0x03, sp)
	jreq	00104$
;	../calloc.c: 58: memset(ptr, 0, msize);
	ldw	x, (0x01, sp)
	pushw	x
	clrw	x
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	call	_memset
	addw	sp, #6
00104$:
;	../calloc.c: 60: return(ptr);
	ldw	x, (0x05, sp)
00105$:
;	../calloc.c: 61: }
	addw	sp, #6
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
