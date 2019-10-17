;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module strtol
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strtoul
	.globl _strtol
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
;	../strtol.c: 38: long int strtol(const char *nptr, char **endptr, int base)
;	-----------------------------------------
;	 function strtol
;	-----------------------------------------
_strtol:
	sub	sp, #11
;	../strtol.c: 40: const char *ptr = nptr;
	ldw	y, (0x0e, sp)
;	../strtol.c: 45: while (isblank (*ptr))
00101$:
	ld	a, (y)
	ld	(0x09, sp), a
;	../strtol.c: 46: ptr++;
	ldw	x, y
	incw	x
	ldw	(0x0a, sp), x
;	./../../include/ctype.h: 53: return ((unsigned char)c == ' ' || (unsigned char)c == '\t');
	cp	a, #0x20
	jreq	00132$
	cp	a, #0x09
	jrne	00158$
00132$:
;	../strtol.c: 46: ptr++;
	ldw	y, (0x0a, sp)
	jra	00101$
00158$:
	ldw	(0x03, sp), y
;	../strtol.c: 50: if (*ptr == '-')
	ld	a, (0x09, sp)
;	../strtol.c: 52: neg = true;
	sub	a, #0x2d
	jrne	00105$
	inc	a
	ld	(0x05, sp), a
;	../strtol.c: 53: ptr++;
	ldw	y, (0x0a, sp)
	ldw	(0x03, sp), y
;	../strtol.c: 56: neg = false;
	.byte 0xc5
00105$:
	clr	(0x05, sp)
00106$:
;	../strtol.c: 62: *endptr = nptr;
	ldw	y, (0x10, sp)
	ldw	(0x06, sp), y
;	../strtol.c: 59: if (neg && (isblank (*ptr) || *ptr == '-' || *ptr == '+'))
	tnz	(0x05, sp)
	jreq	00110$
	ldw	x, (0x03, sp)
	ld	a, (x)
	ld	xl, a
;	./../../include/ctype.h: 53: return ((unsigned char)c == ' ' || (unsigned char)c == '\t');
	cp	a, #0x20
	jreq	00109$
	cp	a, #0x09
	jreq	00109$
;	../strtol.c: 59: if (neg && (isblank (*ptr) || *ptr == '-' || *ptr == '+'))
	ld	a, xl
	cp	a, #0x2d
	jreq	00109$
	ld	a, xl
	cp	a, #0x2b
	jrne	00110$
00109$:
;	../strtol.c: 61: if (endptr)
	ldw	x, (0x10, sp)
	jreq	00108$
;	../strtol.c: 62: *endptr = nptr;
	ldw	x, (0x06, sp)
	ldw	y, (0x0e, sp)
	ldw	(x), y
00108$:
;	../strtol.c: 63: return (0);
	clrw	x
	clrw	y
	jp	00129$
00110$:
;	../strtol.c: 66: u = strtoul(ptr, &rptr, base);
	ldw	x, sp
	incw	x
	ldw	y, (0x12, sp)
	pushw	y
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	call	_strtoul
	addw	sp, #6
	ldw	(0x0a, sp), x
	ldw	(0x08, sp), y
;	../strtol.c: 69: if (rptr == ptr)
	ldw	x, (0x01, sp)
	cpw	x, (0x03, sp)
	jrne	00117$
;	../strtol.c: 71: if (endptr)
	ldw	x, (0x10, sp)
	jreq	00115$
;	../strtol.c: 72: *endptr = nptr;
	ldw	x, (0x06, sp)
	ldw	y, (0x0e, sp)
	ldw	(x), y
00115$:
;	../strtol.c: 73: return (0);
	clrw	x
	clrw	y
	jra	00129$
00117$:
;	../strtol.c: 76: if (endptr)
	ldw	x, (0x10, sp)
	jreq	00119$
;	../strtol.c: 77: *endptr = rptr;
	ldw	x, (0x06, sp)
	ldw	y, (0x01, sp)
	ldw	(x), y
00119$:
;	../strtol.c: 80: if (!neg && u > LONG_MAX)
	tnz	(0x05, sp)
	jrne	00124$
	clrw	x
	decw	x
	cpw	x, (0x0a, sp)
	ld	a, #0xff
	sbc	a, (0x09, sp)
	ld	a, #0x7f
	sbc	a, (0x08, sp)
	jrnc	00124$
;	../strtol.c: 82: errno = ERANGE;
	ldw	x, #0x0022
	ldw	_errno+0, x
;	../strtol.c: 83: return (LONG_MAX);
	clrw	x
	decw	x
	ldw	y, #0x7fff
	jra	00129$
00124$:
;	../strtol.c: 85: else if (neg && u > -LONG_MIN)
	tnz	(0x05, sp)
	jreq	00125$
	clrw	x
	cpw	x, (0x0a, sp)
	clr	a
	sbc	a, (0x09, sp)
	ld	a, #0x80
	sbc	a, (0x08, sp)
	jrnc	00125$
;	../strtol.c: 87: errno = ERANGE;
	ldw	x, #0x0022
	ldw	_errno+0, x
;	../strtol.c: 88: return (LONG_MIN);
	clrw	x
	ldw	y, #0x8000
	jra	00129$
00125$:
;	../strtol.c: 91: return (neg ? -u : u);
	tnz	(0x05, sp)
	jreq	00137$
	ldw	y, (0x0a, sp)
	negw	y
	ldw	x, (0x08, sp)
	jrnc	00258$
	incw	x
00258$:
	negw	x
	ldw	(0x0a, sp), y
	ldw	(0x08, sp), x
00137$:
	ldw	x, (0x0a, sp)
	ldw	y, (0x08, sp)
00129$:
;	../strtol.c: 92: }
	addw	sp, #11
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
