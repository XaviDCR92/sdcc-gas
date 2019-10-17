;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module strndup
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _malloc
	.globl ___memcpy
	.globl _strlen
	.globl _strndup
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
;	../strndup.c: 33: char *strndup (const char *s, size_t n)
;	-----------------------------------------
;	 function strndup
;	-----------------------------------------
_strndup:
	sub	sp, #4
;	../strndup.c: 35: size_t l = strlen (s);
	ldw	x, (0x08, sp)
	pushw	x
	callf	_strlen
	addw	sp, #2
;	../strndup.c: 36: if (l > n)
	ldw	(0x01, sp), x
	cpw	x, (0x0a, sp)
	jrule	00102$
;	../strndup.c: 37: l = n;
	ldw	y, (0x0a, sp)
	ldw	(0x01, sp), y
00102$:
;	../strndup.c: 38: char *r = malloc (l + 1);
	ldw	x, (0x01, sp)
	incw	x
	pushw	x
	callf	_malloc
	addw	sp, #2
;	../strndup.c: 39: if (r)
	ldw	(0x03, sp), x
	jreq	00104$
;	../strndup.c: 41: memcpy (r, s, l);
	ldw	y, (0x08, sp)
	ldw	x, (0x03, sp)
	ld	a, (0x02, sp)
	push	a
	ld	a, (0x02, sp)
	push	a
	pushw	y
	pushw	x
	callf	___memcpy
	addw	sp, #6
;	../strndup.c: 42: r[l] = 0;
	ldw	x, (0x03, sp)
	addw	x, (0x01, sp)
	clr	(x)
00104$:
;	../strndup.c: 44: return (r);
	ldw	x, (0x03, sp)
;	../strndup.c: 45: }
	addw	sp, #4
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
