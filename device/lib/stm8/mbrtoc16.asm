;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module mbrtoc16
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _mbrtowc
	.globl _mbrtoc16
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_mbrtoc16_sps_65536_16:
	.ds 3
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
;	../mbrtoc16.c: 34: size_t mbrtoc16(char16_t *restrict pc16, const char *restrict s, size_t n, mbstate_t *restrict ps)
;	-----------------------------------------
;	 function mbrtoc16
;	-----------------------------------------
_mbrtoc16:
	sub	sp, #14
;	../mbrtoc16.c: 41: if(!s)
	ldw	x, (0x13, sp)
	jrne	00102$
;	../mbrtoc16.c: 42: return(mbrtoc16(0, "", 1, ps));
	ldw	x, (0x17, sp)
	pushw	x
	push	#0x01
	push	#0x00
	push	#<(___str_0 + 0)
	push	#((___str_0 + 0) >> 8)
	clrw	x
	pushw	x
	callr	_mbrtoc16
	addw	sp, #8
	jp	00119$
00102$:
;	../mbrtoc16.c: 44: if(!ps)
	ldw	x, (0x17, sp)
	jrne	00104$
;	../mbrtoc16.c: 45: ps = &sps;
	ldw	x, #(_mbrtoc16_sps_65536_16 + 0)
	ldw	(0x17, sp), x
00104$:
;	../mbrtoc16.c: 47: if(!ps->c[0] && (ps->c[1] || ps->c[2]))
	ldw	y, (0x17, sp)
	ldw	(0x07, sp), y
	ldw	x, y
	ld	a, (x)
;	../mbrtoc16.c: 50: *pc16 = ps->c[1] + (ps->c[2] << 8);
	ldw	y, (0x11, sp)
	ldw	(0x05, sp), y
;	../mbrtoc16.c: 47: if(!ps->c[0] && (ps->c[1] || ps->c[2]))
	ldw	x, (0x07, sp)
	incw	x
	ldw	(0x09, sp), x
	ldw	x, (0x07, sp)
	incw	x
	incw	x
	ldw	(0x0b, sp), x
	tnz	a
	jrne	00108$
	ldw	x, (0x09, sp)
	ld	a, (x)
	jrne	00107$
	ldw	x, (0x0b, sp)
	ld	a, (x)
	jreq	00108$
00107$:
;	../mbrtoc16.c: 50: *pc16 = ps->c[1] + (ps->c[2] << 8);
	ldw	y, (0x17, sp)
	ldw	x, y
	incw	x
	ldw	(0x07, sp), x
	ldw	x, y
	incw	x
	incw	x
	ldw	(0x09, sp), x
;	../mbrtoc16.c: 49: if(pc16)
	ldw	x, (0x11, sp)
	jreq	00106$
;	../mbrtoc16.c: 50: *pc16 = ps->c[1] + (ps->c[2] << 8);
	ldw	x, (0x07, sp)
	ld	a, (x)
	ld	(0x0c, sp), a
	clr	(0x0b, sp)
	ldw	y, (0x09, sp)
	ld	a, (y)
	ld	xh, a
	clr	(0x0e, sp)
	ld	a, (0x0e, sp)
	ld	xl, a
	addw	x, (0x0b, sp)
	ldw	y, (0x05, sp)
	ldw	(y), x
00106$:
;	../mbrtoc16.c: 51: ps->c[1] = ps->c[2] = 0;
	ldw	x, (0x09, sp)
	clr	(x)
	ldw	x, (0x07, sp)
	clr	(x)
;	../mbrtoc16.c: 52: return(-3);
	ldw	x, #0xfffd
	jra	00119$
00108$:
;	../mbrtoc16.c: 55: ret = mbrtowc(&codepoint, s, n, ps);
	ldw	x, sp
	incw	x
	exgw	x, y
	ldw	x, (0x17, sp)
	pushw	x
	ldw	x, (0x17, sp)
	pushw	x
	ldw	x, (0x17, sp)
	pushw	x
	pushw	y
	call	_mbrtowc
	addw	sp, #8
;	../mbrtoc16.c: 57: if(ret > MB_LEN_MAX)
	ldw	(0x0d, sp), x
	cpw	x, #0x0004
	jrule	00112$
;	../mbrtoc16.c: 58: return(ret);
	ldw	x, (0x0d, sp)
	jra	00119$
00112$:
;	../mbrtoc16.c: 60: if (codepoint <= 0xffff) // Basic multilingual plane
	ldw	x, (0x01, sp)
	jrne	00116$
;	../mbrtoc16.c: 62: if(pc16)
	ldw	x, (0x11, sp)
	jreq	00114$
;	../mbrtoc16.c: 63: *pc16 = codepoint;
	ldw	y, (0x03, sp)
	ldw	x, (0x05, sp)
	ldw	(x), y
00114$:
;	../mbrtoc16.c: 64: return(ret);
	ldw	x, (0x0d, sp)
	jra	00119$
00116$:
;	../mbrtoc16.c: 67: codepoint -= 0x100000;
	ldw	y, (0x03, sp)
	ldw	x, (0x01, sp)
	subw	x, #0x0010
	ldw	(0x03, sp), y
	ldw	(0x01, sp), x
;	../mbrtoc16.c: 68: if(pc16)
	ldw	x, (0x11, sp)
	jreq	00118$
;	../mbrtoc16.c: 69: *pc16 = ((codepoint >> 10) & 0x3ff) + 0xd800;
	ldw	x, (0x02, sp)
	ld	a, (0x01, sp)
	srl	a
	rrcw	x
	srl	a
	rrcw	x
	ld	a, xh
	and	a, #0x03
	ld	xh, a
	addw	x, #0xd800
	ldw	y, (0x05, sp)
	ldw	(y), x
00118$:
;	../mbrtoc16.c: 70: low_surrogate = (codepoint & 0x3ff) + 0xdc00;
	ldw	x, (0x03, sp)
	ld	a, xh
	and	a, #0x03
	ld	xh, a
	addw	x, #0xdc00
;	../mbrtoc16.c: 71: ps->c[0] = 0;
	ldw	y, (0x07, sp)
	clr	(y)
;	../mbrtoc16.c: 72: ps->c[1] = low_surrogate & 0xff;
	ld	a, xl
	ldw	y, (0x09, sp)
	ld	(y), a
;	../mbrtoc16.c: 73: ps->c[2] = low_surrogate >> 8;
	ld	a, xh
	ldw	x, (0x0b, sp)
	ld	(x), a
;	../mbrtoc16.c: 75: return(ret);
	ldw	x, (0x0d, sp)
00119$:
;	../mbrtoc16.c: 76: }
	addw	sp, #14
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
