;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module puts
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _putchar
	.globl _puts
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
;	../puts.c: 31: int puts (const char *s)
;	-----------------------------------------
;	 function puts
;	-----------------------------------------
_puts:
;	../puts.c: 33: while (*s)
	ldw	y, (0x04, sp)
00103$:
	ld	a, (y)
	jreq	00105$
;	../puts.c: 34: if (putchar(*s++) == EOF)
	incw	y
	clrw	x
	ld	xl, a
	pushw	y
	pushw	x
	callf	_putchar
	addw	sp, #2
	popw	y
	incw	x
	jrne	00103$
;	../puts.c: 35: return EOF;
	clrw	x
	decw	x
	jra	00106$
00105$:
;	../puts.c: 36: return putchar('\n');
	push	#0x0a
	push	#0x00
	callf	_putchar
	addw	sp, #2
00106$:
;	../puts.c: 37: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
