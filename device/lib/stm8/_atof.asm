;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _atof
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _atoi
	.globl _toupper
	.globl _isspace
	.globl _atof
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
;	../_atof.c: 33: float atof(const char * s)
;	-----------------------------------------
;	 function atof
;	-----------------------------------------
_atof:
	sub	sp, #17
;	../_atof.c: 40: while (isspace(*s)) s++;
	ldw	y, (0x14, sp)
	ldw	(0x10, sp), y
00101$:
	ldw	x, (0x10, sp)
	ld	a, (x)
	clrw	x
	ld	xl, a
	pushw	x
	call	_isspace
	addw	sp, #2
	ldw	y, (0x10, sp)
	incw	y
	tnzw	x
	jreq	00155$
	ldw	(0x10, sp), y
	jra	00101$
00155$:
	ldw	x, (0x10, sp)
	ldw	(0x14, sp), x
;	../_atof.c: 43: if (*s == '-')
	ldw	x, (0x10, sp)
	ld	a, (x)
	cp	a, #0x2d
	jrne	00107$
;	../_atof.c: 45: sign=1;
	ld	a, #0x01
	ld	(0x05, sp), a
;	../_atof.c: 46: s++;
	ldw	(0x14, sp), y
	jra	00108$
00107$:
;	../_atof.c: 50: sign=0;
	clr	(0x05, sp)
;	../_atof.c: 51: if (*s == '+') s++;
	cp	a, #0x2b
	jrne	00108$
	ldw	(0x14, sp), y
00108$:
;	../_atof.c: 55: for (value=0.0; isdigit(*s); s++)
	clrw	x
	ldw	(0x08, sp), x
	ldw	(0x06, sp), x
	ldw	y, (0x14, sp)
	ldw	(0x0c, sp), y
00126$:
	ldw	x, (0x0c, sp)
	ld	a, (x)
	ld	(0x0e, sp), a
	ld	(0x0f, sp), a
	ldw	x, (0x0c, sp)
	incw	x
	ldw	(0x10, sp), x
;	./../../include/ctype.h: 62: return ((unsigned char)c >= '0' && (unsigned char)c <= '9');
	ld	a, (0x0f, sp)
	cp	a, #0x30
	jrc	00156$
	cp	a, #0x39
	jrugt	00156$
;	../_atof.c: 57: value=10.0*value+(*s-'0');
	ldw	x, (0x08, sp)
	pushw	x
	ldw	x, (0x08, sp)
	pushw	x
	clrw	x
	pushw	x
	push	#0x20
	push	#0x41
	call	___fsmul
	addw	sp, #8
	ldw	(0x0c, sp), x
	ldw	(0x0a, sp), y
	clrw	x
	ld	a, (0x0e, sp)
	ld	xl, a
	subw	x, #0x0030
	pushw	x
	call	___sint2fs
	addw	sp, #2
	pushw	x
	pushw	y
	ldw	x, (0x10, sp)
	pushw	x
	ldw	x, (0x10, sp)
	pushw	x
	call	___fsadd
	addw	sp, #8
	ldw	(0x08, sp), x
	ldw	(0x06, sp), y
;	../_atof.c: 55: for (value=0.0; isdigit(*s); s++)
	ldw	y, (0x10, sp)
	ldw	(0x0c, sp), y
	jra	00126$
00156$:
	ldw	y, (0x0c, sp)
	ldw	(0x14, sp), y
;	../_atof.c: 61: if (*s == '.')
	ld	a, (0x0e, sp)
	cp	a, #0x2e
	jrne	00112$
;	../_atof.c: 64: for (fraction=0.1; isdigit(*s); s++)
	ldw	x, #0xcccd
	ldw	(0x0c, sp), x
	ldw	x, #0x3dcc
	ldw	(0x0a, sp), x
00129$:
	ldw	x, (0x10, sp)
	ld	a, (x)
	ld	(0x0e, sp), a
;	./../../include/ctype.h: 62: return ((unsigned char)c >= '0' && (unsigned char)c <= '9');
	ld	(0x0f, sp), a
	cp	a, #0x30
	jrc	00157$
	ld	a, (0x0f, sp)
	cp	a, #0x39
	jrugt	00157$
;	../_atof.c: 66: value+=(*s-'0')*fraction;
	clrw	x
	ld	a, (0x0e, sp)
	ld	xl, a
	subw	x, #0x0030
	pushw	x
	call	___sint2fs
	addw	sp, #2
	ldw	(0x03, sp), x
	ldw	x, (0x0c, sp)
	pushw	x
	ldw	x, (0x0c, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	pushw	y
	call	___fsmul
	addw	sp, #8
	pushw	x
	pushw	y
	ldw	x, (0x0c, sp)
	pushw	x
	ldw	x, (0x0c, sp)
	pushw	x
	call	___fsadd
	addw	sp, #8
	ldw	(0x08, sp), x
	ldw	(0x06, sp), y
;	../_atof.c: 67: fraction*=0.1;
	ldw	x, (0x0c, sp)
	pushw	x
	ldw	x, (0x0c, sp)
	pushw	x
	push	#0xcd
	push	#0xcc
	push	#0xcc
	push	#0x3d
	call	___fsmul
	addw	sp, #8
	ldw	(0x0c, sp), x
	ldw	(0x0a, sp), y
;	../_atof.c: 64: for (fraction=0.1; isdigit(*s); s++)
	ldw	x, (0x10, sp)
	incw	x
	ldw	(0x10, sp), x
	jra	00129$
00157$:
	ldw	y, (0x10, sp)
	ldw	(0x14, sp), y
00112$:
;	../_atof.c: 72: if (toupper(*s)=='E')
	ldw	y, (0x14, sp)
	ldw	(0x10, sp), y
	ldw	x, y
	ld	a, (x)
	clrw	x
	ld	xl, a
	pushw	x
	call	_toupper
	addw	sp, #2
	cpw	x, #0x0045
	jrne	00120$
;	../_atof.c: 74: s++;
	ldw	x, (0x10, sp)
	incw	x
;	../_atof.c: 75: iexp=(signed char)atoi(s);
	ldw	(0x14, sp), x
	pushw	x
	call	_atoi
	addw	sp, #2
	ld	a, xl
;	../_atof.c: 77: while(iexp!=0)
00116$:
	tnz	a
	jreq	00120$
;	../_atof.c: 79: if(iexp<0)
	tnz	a
	jrpl	00114$
;	../_atof.c: 81: value*=0.1;
	push	a
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	push	#0xcd
	push	#0xcc
	push	#0xcc
	push	#0x3d
	call	___fsmul
	addw	sp, #8
	pop	a
	ldw	(0x08, sp), x
	ldw	(0x06, sp), y
;	../_atof.c: 82: iexp++;
	inc	a
	jra	00116$
00114$:
;	../_atof.c: 86: value*=10.0;
	push	a
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	clrw	x
	pushw	x
	push	#0x20
	push	#0x41
	call	___fsmul
	addw	sp, #8
	pop	a
	ldw	(0x08, sp), x
	ldw	(0x06, sp), y
;	../_atof.c: 87: iexp--;
	dec	a
	jra	00116$
00120$:
;	../_atof.c: 93: if(sign) value*=-1.0;
	tnz	(0x05, sp)
	jreq	00122$
	ldw	y, (0x08, sp)
	ldw	x, (0x06, sp)
	sllw	x
	ccf
	rrcw	x
	ldw	(0x08, sp), y
	ldw	(0x06, sp), x
00122$:
;	../_atof.c: 94: return (value);
	ldw	x, (0x08, sp)
	ldw	y, (0x06, sp)
;	../_atof.c: 95: }
	addw	sp, #17
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
