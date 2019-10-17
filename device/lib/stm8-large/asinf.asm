;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module asinf
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _asincosf
	.globl _asinf
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
;	../asinf.c: 36: float asinf(float x) _FLOAT_FUNC_REENTRANT
;	-----------------------------------------
;	 function asinf
;	-----------------------------------------
_asinf:
;	../asinf.c: 38: if (x == 1.0) return  HALF_PI;
	clrw	x
	pushw	x
	push	#0x80
	push	#0x3f
	ldw	x, (0x0a, sp)
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	callf	___fseq
	addw	sp, #8
	tnz	a
	jreq	00108$
	ldw	x, #0x0fdb
	ldw	y, #0x3fc9
	jra	00110$
00108$:
;	../asinf.c: 39: else if (x ==-1.0) return -HALF_PI;
	clrw	x
	pushw	x
	push	#0x80
	push	#0xbf
	ldw	x, (0x0a, sp)
	pushw	x
	ldw	x, (0x0a, sp)
	pushw	x
	callf	___fseq
	addw	sp, #8
	tnz	a
	jreq	00105$
	ldw	x, #0x0fdb
	ldw	y, #0xbfc9
	jra	00110$
00105$:
;	../asinf.c: 40: else if (x == 0.0) return 0.0;
	ldw	x, (0x06, sp)
	jrne	00102$
	ldw	x, (0x04, sp)
	sllw	x
	jrne	00102$
	clrw	x
	clrw	y
	jra	00110$
00102$:
;	../asinf.c: 41: else               return asincosf(x, false);
	push	#0x00
	ldw	x, (0x07, sp)
	pushw	x
	ldw	x, (0x07, sp)
	pushw	x
	callf	_asincosf
	addw	sp, #5
00110$:
;	../asinf.c: 42: }
	retf
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
