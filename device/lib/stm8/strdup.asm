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
	ldw	x, (0x03, sp)
	pushw	x
	call	_strlen
	addw	sp, #2
	incw	x
	pushw	x
	call	_malloc
	addw	sp, #2
;	../strdup.c: 36: if (r)
	tnzw	x
	jrne	00110$
	ret
00110$:
;	../strdup.c: 37: strcpy(r, s);
	pushw	x
	ldw	y, (0x05, sp)
	pushw	y
	pushw	x
	call	_strcpy
	addw	sp, #4
	popw	x
;	../strdup.c: 38: return (r);
;	../strdup.c: 39: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
