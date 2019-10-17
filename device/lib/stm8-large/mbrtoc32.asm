;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module mbrtoc32
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _mbrtowc
	.globl _mbrtoc32
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_mbrtoc32_sps_65536_16:
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
;	../mbrtoc32.c: 34: size_t mbrtoc32(char32_t *restrict pc32, const char *restrict s, size_t n, mbstate_t *restrict ps)
;	-----------------------------------------
;	 function mbrtoc32
;	-----------------------------------------
_mbrtoc32:
	sub	sp, #6
;	../mbrtoc32.c: 40: if(!ps)
	ldw	x, (0x10, sp)
	jrne	00102$
;	../mbrtoc32.c: 41: ps = &sps;
	ldw	x, #(_mbrtoc32_sps_65536_16 + 0)
	ldw	(0x10, sp), x
00102$:
;	../mbrtoc32.c: 43: if(!pc32)
	ldw	x, (0x0a, sp)
	jrne	00104$
;	../mbrtoc32.c: 44: return(mbrtowc(0, s, n, ps));
	ldw	x, (0x10, sp)
	pushw	x
	ldw	x, (0x10, sp)
	pushw	x
	ldw	x, (0x10, sp)
	pushw	x
	clrw	x
	pushw	x
	callf	_mbrtowc
	addw	sp, #8
	jra	00107$
00104$:
;	../mbrtoc32.c: 46: ret = mbrtowc(&wc, s, n, ps);
	ldw	x, sp
	incw	x
	exgw	x, y
	ldw	x, (0x10, sp)
	pushw	x
	ldw	x, (0x10, sp)
	pushw	x
	ldw	x, (0x10, sp)
	pushw	x
	pushw	y
	callf	_mbrtowc
	addw	sp, #8
;	../mbrtoc32.c: 48: if(ret <= MB_LEN_MAX)
	ldw	(0x05, sp), x
	cpw	x, #0x0004
	jrugt	00106$
;	../mbrtoc32.c: 49: *pc32 = wc;
	ldw	x, (0x0a, sp)
	ldw	y, (0x03, sp)
	ldw	(0x2, x), y
	ldw	y, (0x01, sp)
	ldw	(x), y
00106$:
;	../mbrtoc32.c: 51: return(ret);
	ldw	x, (0x05, sp)
00107$:
;	../mbrtoc32.c: 52: }
	addw	sp, #6
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
