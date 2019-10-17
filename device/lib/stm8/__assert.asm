;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module __assert
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___assert
	.globl _printf
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
;	../__assert.c: 32: void __assert(const char *expression, const char *functionname, const char *filename, unsigned int linenumber)
;	-----------------------------------------
;	 function __assert
;	-----------------------------------------
___assert:
;	../__assert.c: 34: printf("Assert(%s) failed in function %s at line %u in file %s.\n",
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x0b, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	push	#<(___str_0 + 0)
	push	#((___str_0 + 0) >> 8)
	call	_printf
	addw	sp, #10
00103$:
	jra	00103$
;	../__assert.c: 37: }
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "Assert(%s) failed in function %s at line %u in file %s."
	.db 0x0a
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
