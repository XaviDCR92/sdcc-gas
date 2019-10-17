;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module aligned_alloc
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _malloc
	.globl _aligned_alloc
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
;	./../../include/stdlib.h: 86: inline void *aligned_alloc(size_t alignment, size_t size)
;	-----------------------------------------
;	 function aligned_alloc
;	-----------------------------------------
_aligned_alloc:
;	./../../include/stdlib.h: 89: return malloc(size);
	ldw	x, (0x06, sp)
	pushw	x
	callf	_malloc
	addw	sp, #2
;	./../../include/stdlib.h: 90: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
