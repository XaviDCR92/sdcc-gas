;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module sprintf
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl __print_format
	.globl _vsprintf
	.globl _sprintf
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
;	../sprintf.c: 34: put_char_to_string (char c, void* p) _REENTRANT
;	-----------------------------------------
;	 function put_char_to_string
;	-----------------------------------------
_put_char_to_string:
	sub	sp, #2
;	../sprintf.c: 36: char **buf = (char **)p;
	ldw	y, (0x06, sp)
;	../sprintf.c: 37: *(*buf)++ = c;
	ldw	x, y
	ldw	x, (x)
	ldw	(0x01, sp), x
	incw	x
	ldw	(y), x
	ldw	x, (0x01, sp)
	ld	a, (0x05, sp)
	ld	(x), a
;	../sprintf.c: 38: }
	addw	sp, #2
	ret
;	../sprintf.c: 41: vsprintf (char *buf, const char *format, va_list ap)
;	-----------------------------------------
;	 function vsprintf
;	-----------------------------------------
_vsprintf:
;	../sprintf.c: 44: i = _print_format (put_char_to_string, &buf, format, ap);
	ldw	x, sp
	addw	x, #3
	ldw	y, (0x07, sp)
	pushw	y
	ldw	y, (0x07, sp)
	pushw	y
	pushw	x
	push	#<(_put_char_to_string + 0)
	push	#((_put_char_to_string + 0) >> 8)
	call	__print_format
	addw	sp, #8
;	../sprintf.c: 45: *buf = 0;
	ldw	y, (0x03, sp)
	clr	(y)
;	../sprintf.c: 46: return i;
;	../sprintf.c: 47: }
	ret
;	../sprintf.c: 50: sprintf (char *buf, const char *format, ...)
;	-----------------------------------------
;	 function sprintf
;	-----------------------------------------
_sprintf:
;	../sprintf.c: 55: va_start (arg, format);
	ldw	x, sp
	addw	x, #5
	incw	x
	incw	x
	exgw	x, y
;	../sprintf.c: 56: i = _print_format (put_char_to_string, &buf, format, arg);
	ldw	x, sp
	addw	x, #3
	pushw	y
	ldw	y, (0x07, sp)
	pushw	y
	pushw	x
	push	#<(_put_char_to_string + 0)
	push	#((_put_char_to_string + 0) >> 8)
	call	__print_format
	addw	sp, #8
;	../sprintf.c: 57: *buf = 0;
	ldw	y, (0x03, sp)
	clr	(y)
;	../sprintf.c: 60: return i;
;	../sprintf.c: 61: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
