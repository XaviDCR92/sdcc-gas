;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module strdup
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _malloc
	.globl _strlen
	.globl _strcpy
	.globl _strdup
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
;	../strdup.c: 33: char *strdup (const char *s)
;	-----------------------------------------
;	 function strdup
;	-----------------------------------------
_strdup:
;	../strdup.c: 35: char *r = malloc(strlen(s) + 1);
	ldw	x, (0x04, sp)
	pushw	x
	callf	_strlen
	addw	sp, #2
	incw	x
	pushw	x
	callf	_malloc
	addw	sp, #2
;	../strdup.c: 36: if (r)
	tnzw	x
	jreq	00102$
;	../strdup.c: 37: strcpy(r, s);
	pushw	x
	ldw	y, (0x06, sp)
	pushw	y
	pushw	x
	callf	_strcpy
	addw	sp, #4
	popw	x
00102$:
;	../strdup.c: 38: return (r);
;	../strdup.c: 39: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
