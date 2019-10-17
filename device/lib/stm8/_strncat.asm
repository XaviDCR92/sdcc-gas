;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _strncat
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strncat
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
;	../_strncat.c: 31: char * strncat ( char * front, const char * back, size_t count )
;	-----------------------------------------
;	 function strncat
;	-----------------------------------------
_strncat:
	sub	sp, #10
;	../_strncat.c: 33: char *start = front;
	ldw	y, (0x0d, sp)
;	../_strncat.c: 35: while (*front++);
	ldw	(0x01, sp), y
	ldw	x, y
00101$:
	ld	a, (x)
	incw	x
	tnz	a
	jrne	00101$
;	../_strncat.c: 37: front--;
	decw	x
	ldw	(0x0d, sp), x
;	../_strncat.c: 39: while (count--)
	ldw	y, (0x0f, sp)
	ldw	(0x05, sp), y
	ldw	y, (0x0d, sp)
	ldw	(0x07, sp), y
	ldw	y, (0x11, sp)
	ldw	(0x09, sp), y
00106$:
	ldw	y, (0x09, sp)
	ldw	(0x03, sp), y
	ldw	x, (0x09, sp)
	decw	x
	ldw	(0x09, sp), x
	ldw	x, (0x03, sp)
	jreq	00108$
;	../_strncat.c: 40: if (!(*front++ = *back++))
	ldw	x, (0x05, sp)
	ld	a, (x)
	ldw	x, (0x05, sp)
	incw	x
	ldw	(0x05, sp), x
	ldw	x, (0x07, sp)
	ld	(x), a
	ldw	x, (0x07, sp)
	incw	x
	ldw	(0x07, sp), x
	ldw	(0x0d, sp), x
	tnz	a
	jrne	00106$
;	../_strncat.c: 41: return(start);
	ldw	x, (0x01, sp)
	jra	00109$
00108$:
;	../_strncat.c: 43: *front = '\0';
	ldw	y, (0x0d, sp)
	ldw	(0x09, sp), y
	ldw	x, y
	clr	(x)
;	../_strncat.c: 44: return(start);
	ldw	x, (0x01, sp)
00109$:
;	../_strncat.c: 45: }
	addw	sp, #10
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
