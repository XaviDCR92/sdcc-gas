;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module gets
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _gets
	.globl _putchar
	.globl _getchar
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
;	../gets.c: 32: gets (char *s)
;	-----------------------------------------
;	 function gets
;	-----------------------------------------
_gets:
	sub	sp, #2
;	../gets.c: 35: unsigned int count = 0;
	clrw	x
	ldw	(0x01, sp), x
;	../gets.c: 37: while (1)
00109$:
;	../gets.c: 39: c = getchar ();
	call	_getchar
	ld	a, xl
;	../gets.c: 40: switch(c)
	cp	a, #0x08
	jreq	00101$
;	../gets.c: 57: *s = 0;
	ldw	x, (0x05, sp)
;	../gets.c: 40: switch(c)
	cp	a, #0x0a
	jreq	00105$
	cp	a, #0x0d
	jreq	00105$
	jra	00106$
;	../gets.c: 42: case '\b': /* backspace */
00101$:
;	../gets.c: 43: if (count)
	ldw	x, (0x01, sp)
	jreq	00109$
;	../gets.c: 45: putchar ('\b');
	push	#0x08
	push	#0x00
	call	_putchar
	addw	sp, #2
;	../gets.c: 46: putchar (' ');
	push	#0x20
	push	#0x00
	call	_putchar
	addw	sp, #2
;	../gets.c: 47: putchar ('\b');
	push	#0x08
	push	#0x00
	call	_putchar
	addw	sp, #2
;	../gets.c: 48: --s;
	ldw	x, (0x05, sp)
	decw	x
	ldw	(0x05, sp), x
;	../gets.c: 49: --count;
	ldw	x, (0x01, sp)
	decw	x
	ldw	(0x01, sp), x
;	../gets.c: 51: break;
	jra	00109$
;	../gets.c: 54: case '\r': /* CR or LF */
00105$:
;	../gets.c: 55: putchar ('\r');
	pushw	x
	push	#0x0d
	push	#0x00
	call	_putchar
	addw	sp, #2
	push	#0x0a
	push	#0x00
	call	_putchar
	addw	sp, #2
	popw	x
;	../gets.c: 57: *s = 0;
	clr	(x)
;	../gets.c: 58: return s;
	jra	00111$
;	../gets.c: 60: default:
00106$:
;	../gets.c: 61: *s++ = c;
	ld	(x), a
	incw	x
	ldw	(0x05, sp), x
;	../gets.c: 62: ++count;
	ldw	x, (0x01, sp)
	incw	x
	ldw	(0x01, sp), x
;	../gets.c: 63: putchar (c);
	clrw	x
	ld	xl, a
	pushw	x
	call	_putchar
	addw	sp, #2
;	../gets.c: 65: }
	jra	00109$
00111$:
;	../gets.c: 67: }
	addw	sp, #2
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
