;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module vprintf
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _putchar
	.globl __print_format
	.globl _vprintf
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
;	../vprintf.c: 34: put_char_to_stdout (char c, void* p) _REENTRANT
;	-----------------------------------------
;	 function put_char_to_stdout
;	-----------------------------------------
_put_char_to_stdout:
;	../vprintf.c: 37: putchar (c);
	clrw	x
	ld	a, (0x03, sp)
	ld	xl, a
	pushw	x
	call	_putchar
	addw	sp, #2
;	../vprintf.c: 38: }
	ret
;	../vprintf.c: 41: vprintf (const char *format, va_list ap)
;	-----------------------------------------
;	 function vprintf
;	-----------------------------------------
_vprintf:
;	../vprintf.c: 43: return _print_format (put_char_to_stdout, NULL, format, ap);
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	clrw	x
	pushw	x
	push	#<(_put_char_to_stdout + 0)
	push	#((_put_char_to_stdout + 0) >> 8)
	call	__print_format
	addw	sp, #8
;	../vprintf.c: 44: }
	ret
;	../vprintf.c: 47: printf (const char *format, ...)
;	-----------------------------------------
;	 function printf
;	-----------------------------------------
_printf:
;	../vprintf.c: 52: va_start (arg, format);
	ldw	x, sp
	addw	x, #3
	incw	x
	incw	x
;	../vprintf.c: 53: i = _print_format (put_char_to_stdout, NULL, format, arg);
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	clrw	x
	pushw	x
	push	#<(_put_char_to_stdout + 0)
	push	#((_put_char_to_stdout + 0) >> 8)
	call	__print_format
	addw	sp, #8
;	../vprintf.c: 56: return i;
;	../vprintf.c: 57: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
