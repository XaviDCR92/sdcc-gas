;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module strtoul
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strncmp
	.globl _strtoul
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
;	../strtoul.c: 37: static signed char _isdigit(const char c, unsigned char base)
;	-----------------------------------------
;	 function _isdigit
;	-----------------------------------------
__isdigit:
;	../strtoul.c: 42: v = c - '0';
;	../strtoul.c: 41: if (c >= '0' && c <= '9')
	ld	a, (0x03, sp)
	ld	xl, a
	cp	a, #0x30
	jrc	00110$
	ld	a, (0x03, sp)
	cp	a, #0x39
	jrugt	00110$
;	../strtoul.c: 42: v = c - '0';
	ld	a, xl
	sub	a, #0x30
	jra	00111$
00110$:
;	../strtoul.c: 43: else if (c >= 'a' && c <='z')
	ld	a, (0x03, sp)
	cp	a, #0x61
	jrc	00106$
	cp	a, #0x7a
	jrugt	00106$
;	../strtoul.c: 44: v = c - 'a' + 10;
	ld	a, xl
	add	a, #0xa9
	jra	00111$
00106$:
;	../strtoul.c: 45: else if (c >= 'A' && c <='Z')
	ld	a, (0x03, sp)
	cp	a, #0x41
	jrc	00102$
	cp	a, #0x5a
	jrugt	00102$
;	../strtoul.c: 46: v = c - 'A' + 10;
	ld	a, xl
	add	a, #0xc9
	jra	00111$
00102$:
;	../strtoul.c: 48: return (-1);
	ld	a, #0xff
	ret
00111$:
;	../strtoul.c: 50: if (v >= base)
	cp	a, (0x04, sp)
	jrnc	00158$
	ret
00158$:
;	../strtoul.c: 51: return (-1);
	ld	a, #0xff
;	../strtoul.c: 53: return (v);
;	../strtoul.c: 54: }
	ret
;	../strtoul.c: 56: unsigned long int strtoul(const char *nptr, char **endptr, int base)
;	-----------------------------------------
;	 function strtoul
;	-----------------------------------------
_strtoul:
	sub	sp, #20
;	../strtoul.c: 58: const char *ptr = nptr;
	ldw	y, (0x17, sp)
;	../strtoul.c: 60: bool range_error = false;
	clr	(0x05, sp)
;	../strtoul.c: 61: bool neg = false;
	clr	(0x06, sp)
;	../strtoul.c: 63: while (isblank (*ptr))
00101$:
	ld	a, (y)
	ld	xl, a
;	./../../include/ctype.h: 53: return ((unsigned char)c == ' ' || (unsigned char)c == '\t');
	cp	a, #0x20
	jreq	00140$
	cp	a, #0x09
	jrne	00163$
00140$:
;	../strtoul.c: 64: ptr++;
	incw	y
	jra	00101$
00163$:
	ldw	(0x13, sp), y
;	../strtoul.c: 67: switch(*ptr)
	ld	a, xl
	cp	a, #0x2b
	jreq	00105$
	ld	a, xl
;	../strtoul.c: 70: neg = true;
	sub	a, #0x2d
	jrne	00106$
	inc	a
	ld	(0x06, sp), a
;	../strtoul.c: 71: case '+':
00105$:
;	../strtoul.c: 72: ptr++;
	ldw	x, (0x13, sp)
	incw	x
	ldw	(0x13, sp), x
;	../strtoul.c: 73: }
00106$:
;	../strtoul.c: 81: ptr += 2;
	ldw	x, (0x13, sp)
	incw	x
	incw	x
	ldw	(0x11, sp), x
;	../strtoul.c: 76: if (!base)
	ldw	x, (0x1b, sp)
	jrne	00119$
;	../strtoul.c: 78: if (!strncmp (ptr, "0x", 2) || !strncmp (ptr, "0X", 2))
	push	#0x02
	push	#0x00
	push	#<(___str_0 + 0)
	push	#((___str_0 + 0) >> 8)
	ldw	x, (0x17, sp)
	pushw	x
	call	_strncmp
	addw	sp, #6
	tnzw	x
	jreq	00110$
	push	#0x02
	push	#0x00
	push	#<(___str_1 + 0)
	push	#((___str_1 + 0) >> 8)
	ldw	x, (0x17, sp)
	pushw	x
	call	_strncmp
	addw	sp, #6
	tnzw	x
	jrne	00111$
00110$:
;	../strtoul.c: 80: base = 16;
	ldw	x, #0x0010
	ldw	(0x1b, sp), x
;	../strtoul.c: 81: ptr += 2;
	ldw	y, (0x11, sp)
	ldw	(0x13, sp), y
	jra	00120$
00111$:
;	../strtoul.c: 83: else if (*ptr == '0')
	ldw	x, (0x13, sp)
	ld	a, (x)
	cp	a, #0x30
	jrne	00108$
;	../strtoul.c: 85: base = 8;
	ldw	x, #0x0008
	ldw	(0x1b, sp), x
;	../strtoul.c: 86: ptr++;
	ldw	x, (0x13, sp)
	incw	x
	ldw	(0x13, sp), x
	jra	00120$
00108$:
;	../strtoul.c: 89: base = 10;
	ldw	x, #0x000a
	ldw	(0x1b, sp), x
	jra	00120$
00119$:
;	../strtoul.c: 92: else if (base == 16 && (!strncmp (ptr, "0x", 2) || !strncmp (ptr, "0X", 2)))
	ldw	x, (0x1b, sp)
	cpw	x, #0x0010
	jrne	00120$
	push	#0x02
	push	#0x00
	push	#<(___str_0 + 0)
	push	#((___str_0 + 0) >> 8)
	ldw	x, (0x17, sp)
	pushw	x
	call	_strncmp
	addw	sp, #6
	tnzw	x
	jreq	00114$
	push	#0x02
	push	#0x00
	push	#<(___str_1 + 0)
	push	#((___str_1 + 0) >> 8)
	ldw	x, (0x17, sp)
	pushw	x
	call	_strncmp
	addw	sp, #6
	tnzw	x
	jrne	00120$
00114$:
;	../strtoul.c: 93: ptr += 2;
	ldw	y, (0x11, sp)
	ldw	(0x13, sp), y
00120$:
;	../strtoul.c: 97: if (_isdigit (*ptr, base) < 0)
	ld	a, (0x1c, sp)
	ld	(0x07, sp), a
	ldw	x, (0x13, sp)
	ld	a, (x)
	ld	xl, a
	ld	a, (0x07, sp)
	push	a
	ld	a, xl
	push	a
	call	__isdigit
	addw	sp, #2
;	../strtoul.c: 100: *endptr = (char*)nptr;
	ldw	y, (0x19, sp)
	ldw	(0x08, sp), y
;	../strtoul.c: 97: if (_isdigit (*ptr, base) < 0)
	tnz	a
	jrpl	00124$
;	../strtoul.c: 99: if (endptr)
	ldw	x, (0x19, sp)
	jreq	00122$
;	../strtoul.c: 100: *endptr = (char*)nptr;
	ldw	x, (0x08, sp)
	ldw	y, (0x17, sp)
	ldw	(x), y
00122$:
;	../strtoul.c: 101: return (0);
	clrw	x
	clrw	y
	jp	00137$
00124$:
;	../strtoul.c: 104: for (ret = 0;; ptr++)
	clrw	x
	ldw	(0x11, sp), x
	ldw	(0x0f, sp), x
00135$:
;	../strtoul.c: 107: signed char digit = _isdigit (*ptr, base);
	ldw	x, (0x13, sp)
	ld	a, (x)
	ld	xl, a
	ld	a, (0x07, sp)
	push	a
	ld	a, xl
	push	a
	call	__isdigit
	addw	sp, #2
;	../strtoul.c: 109: if (digit < 0)
	ld	(0x0a, sp), a
	jrmi	00129$
;	../strtoul.c: 112: oldret = ret;
	ldw	y, (0x11, sp)
	ldw	(0x0d, sp), y
	ldw	y, (0x0f, sp)
	ldw	(0x0b, sp), y
;	../strtoul.c: 113: ret *= base;
	ldw	y, (0x1b, sp)
	clrw	x
	tnzw	y
	jrpl	00261$
	decw	x
00261$:
	pushw	y
	pushw	x
	ldw	x, (0x15, sp)
	pushw	x
	ldw	x, (0x15, sp)
	pushw	x
	call	__mullong
	addw	sp, #8
	ldw	(0x11, sp), x
	ldw	(0x0f, sp), y
;	../strtoul.c: 114: if (ret < oldret)
	ldw	x, (0x11, sp)
	cpw	x, (0x0d, sp)
	ld	a, (0x10, sp)
	sbc	a, (0x0c, sp)
	ld	a, (0x0f, sp)
	sbc	a, (0x0b, sp)
	jrnc	00128$
;	../strtoul.c: 115: range_error = true;
	ld	a, #0x01
	ld	(0x05, sp), a
00128$:
;	../strtoul.c: 117: ret += (unsigned char)digit;
	ld	a, (0x0a, sp)
	ld	(0x04, sp), a
	clr	(0x03, sp)
	clr	(0x02, sp)
	clr	(0x01, sp)
	ldw	x, (0x11, sp)
	addw	x, (0x03, sp)
	ldw	(0x0c, sp), x
	ld	a, (0x10, sp)
	adc	a, (0x02, sp)
	ld	(0x0b, sp), a
	ld	a, (0x0f, sp)
	adc	a, (0x01, sp)
	ld	(0x0a, sp), a
	ldw	y, (0x0c, sp)
	ldw	(0x11, sp), y
	ldw	y, (0x0a, sp)
	ldw	(0x0f, sp), y
;	../strtoul.c: 104: for (ret = 0;; ptr++)
	ldw	x, (0x13, sp)
	incw	x
	ldw	(0x13, sp), x
	jra	00135$
00129$:
;	../strtoul.c: 120: if (endptr)
	ldw	x, (0x19, sp)
	jreq	00131$
;	../strtoul.c: 121: *endptr = (char*)ptr;
	ldw	x, (0x08, sp)
	ldw	y, (0x13, sp)
	ldw	(x), y
00131$:
;	../strtoul.c: 123: if (range_error)
	tnz	(0x05, sp)
	jreq	00133$
;	../strtoul.c: 125: errno = ERANGE;
	ldw	x, #0x0022
	ldw	_errno+0, x
;	../strtoul.c: 126: return (ULONG_MAX);
	clrw	x
	decw	x
	ldw	y, x
	jra	00137$
00133$:
;	../strtoul.c: 129: return (neg ? -ret : ret);
	tnz	(0x06, sp)
	jreq	00142$
	ldw	y, (0x11, sp)
	negw	y
	ldw	x, (0x0f, sp)
	jrnc	00267$
	incw	x
00267$:
	negw	x
	ldw	(0x0c, sp), y
	ldw	(0x0a, sp), x
	jra	00143$
00142$:
	ldw	y, (0x11, sp)
	ldw	(0x0c, sp), y
	ldw	y, (0x0f, sp)
	ldw	(0x0a, sp), y
00143$:
	ldw	x, (0x0c, sp)
	ldw	y, (0x0a, sp)
00137$:
;	../strtoul.c: 130: }
	addw	sp, #20
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "0x"
	.db 0x00
	.area CODE
	.area CONST
___str_1:
	.ascii "0X"
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
