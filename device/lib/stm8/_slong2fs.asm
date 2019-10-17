;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module _slong2fs
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___ulong2fs
	.globl ___slong2fs
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
;	../_slong2fs.c: 79: float __slong2fs (signed long sl) {
;	-----------------------------------------
;	 function __slong2fs
;	-----------------------------------------
___slong2fs:
;	../_slong2fs.c: 80: if (sl<0) 
	tnz	(0x03, sp)
	jrpl	00102$
;	../_slong2fs.c: 81: return -__ulong2fs(-sl);
	ldw	y, (0x05, sp)
	negw	y
	ldw	x, (0x03, sp)
	jrnc	00112$
	incw	x
00112$:
	negw	x
	pushw	y
	pushw	x
	call	___ulong2fs
	addw	sp, #4
	sllw	y
	ccf
	rrcw	y
	ret
00102$:
;	../_slong2fs.c: 83: return __ulong2fs(sl);
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	call	___ulong2fs
	addw	sp, #4
;	../_slong2fs.c: 84: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
	.area CABS (ABS)
