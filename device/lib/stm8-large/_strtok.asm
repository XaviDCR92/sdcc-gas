;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _strtok
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strchr
	.globl _strtok
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_strtok_s_65536_26:
	.ds 2
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
;	../_strtok.c: 36: char * strtok ( char * str, const char * control )
;	-----------------------------------------
;	 function strtok
;	-----------------------------------------
_strtok:
	sub	sp, #2
;	../_strtok.c: 41: if ( str )
;	../_strtok.c: 42: s = str;
	ldw	x, (0x06, sp)
	jreq	00102$
	ldw	_strtok_s_65536_26+0, x
00102$:
;	../_strtok.c: 43: if ( !s )
	ldw	x, _strtok_s_65536_26+0
	jrne	00108$
;	../_strtok.c: 44: return NULL;
	clrw	x
	jra	00119$
;	../_strtok.c: 46: while (*s) {
00108$:
	ldw	x, _strtok_s_65536_26+0
	ld	a, (x)
	jreq	00110$
;	../_strtok.c: 47: if (strchr(control,*s))
	clrw	x
	ld	xl, a
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	callf	_strchr
	addw	sp, #4
	tnzw	x
	jreq	00110$
;	../_strtok.c: 48: s++;
	ldw	x, _strtok_s_65536_26+0
	incw	x
	ldw	_strtok_s_65536_26+0, x
	jra	00108$
;	../_strtok.c: 50: break;
00110$:
;	../_strtok.c: 53: s1 = s;
	ldw	x, _strtok_s_65536_26+0
	ldw	(0x01, sp), x
;	../_strtok.c: 55: while (*s) {
00113$:
;	../_strtok.c: 46: while (*s) {
	ldw	x, _strtok_s_65536_26+0
;	../_strtok.c: 55: while (*s) {
	ld	a, (x)
	jreq	00115$
;	../_strtok.c: 56: if (strchr(control,*s)) {
	clrw	x
	ld	xl, a
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	callf	_strchr
	addw	sp, #4
	tnzw	x
	jreq	00112$
;	../_strtok.c: 57: *s++ = '\0';
	ldw	x, _strtok_s_65536_26+0
	clr	(x)
	ldw	x, _strtok_s_65536_26+0
	incw	x
	ldw	_strtok_s_65536_26+0, x
;	../_strtok.c: 58: return s1;
	ldw	x, (0x01, sp)
	jra	00119$
00112$:
;	../_strtok.c: 60: s++ ;
	ldw	x, _strtok_s_65536_26+0
	incw	x
	ldw	_strtok_s_65536_26+0, x
	jra	00113$
00115$:
;	../_strtok.c: 63: s = NULL;
	clrw	x
	ldw	_strtok_s_65536_26+0, x
;	../_strtok.c: 65: if (*s1)
	ldw	x, (0x01, sp)
	ld	a, (x)
	jreq	00117$
;	../_strtok.c: 66: return s1;
	ldw	x, (0x01, sp)
;	../_strtok.c: 68: return NULL;
	.byte 0x21
00117$:
	clrw	x
00119$:
;	../_strtok.c: 69: }
	addw	sp, #2
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
