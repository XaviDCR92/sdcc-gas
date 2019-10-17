;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module strxfrm
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strlen
	.globl _strncpy
	.globl _strxfrm
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
;	../strxfrm.c: 31: size_t strxfrm(char *dest, const char *src, size_t n)
;	-----------------------------------------
;	 function strxfrm
;	-----------------------------------------
_strxfrm:
;	../strxfrm.c: 33: strncpy(dest, src, n);
	ldw	x, (0x08, sp)
	pushw	x
	ldw	x, (0x08, sp)
	pushw	x
	ldw	x, (0x08, sp)
	pushw	x
	callf	_strncpy
	addw	sp, #6
;	../strxfrm.c: 34: return(strlen(src) + 1);
	ldw	x, (0x06, sp)
	pushw	x
	callf	_strlen
	addw	sp, #2
	incw	x
;	../strxfrm.c: 35: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
