;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module rand
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _rand
	.globl _srand
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area INITIALIZED
_s:
	.ds 4
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
;	../rand.c: 40: int rand(void)
;	-----------------------------------------
;	 function rand
;	-----------------------------------------
_rand:
	sub	sp, #8
;	../rand.c: 42: register unsigned long t = s;
	ldw	x, _s+2
	ldw	(0x03, sp), x
	ldw	x, _s+0
	ldw	(0x01, sp), x
;	../rand.c: 44: t ^= t >> 10;
	ldw	y, (0x02, sp)
	ldw	(0x07, sp), y
	ld	a, (0x01, sp)
	ld	(0x06, sp), a
	clr	(0x05, sp)
	srl	(0x06, sp)
	rrc	(0x07, sp)
	rrc	(0x08, sp)
	srl	(0x06, sp)
	rrc	(0x07, sp)
	rrc	(0x08, sp)
	ld	a, (0x04, sp)
	xor	a, (0x08, sp)
	ld	xl, a
	ld	a, (0x03, sp)
	xor	a, (0x07, sp)
	ld	xh, a
	ld	a, (0x02, sp)
	xor	a, (0x06, sp)
	push	a
	ld	a, (0x02, sp)
	xor	a, (0x06, sp)
	ld	yh, a
	pop	a
;	../rand.c: 45: t ^= t << 9;
	ldw	(0x06, sp), x
	ld	(0x05, sp), a
	clr	(0x08, sp)
	sll	(0x08, sp)
	rlc	(0x07, sp)
	rlc	(0x06, sp)
	rlc	(0x05, sp)
	xor	a, (0x06, sp)
	ld	yl, a
	ld	a, xl
	xor	a, (0x08, sp)
	rlwa	x
	xor	a, (0x07, sp)
	ld	xh, a
	ld	a, yh
	xor	a, (0x05, sp)
	ld	yh, a
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	../rand.c: 46: t ^= t >> 25;
	ld	a, (0x01, sp)
	ld	(0x08, sp), a
	clr	(0x07, sp)
	clr	(0x06, sp)
	clr	(0x05, sp)
	srl	(0x08, sp)
	ld	a, (0x04, sp)
	xor	a, (0x08, sp)
	ld	xl, a
	ld	a, (0x03, sp)
	xor	a, (0x07, sp)
	ld	xh, a
	ld	a, (0x02, sp)
	xor	a, (0x06, sp)
	ld	yl, a
	ld	a, (0x01, sp)
	xor	a, (0x05, sp)
	ld	yh, a
;	../rand.c: 48: s = t;
	ldw	_s+2, x
	ldw	_s+0, y
;	../rand.c: 50: return(t & RAND_MAX);
	sllw	x
	srlw	x
;	../rand.c: 51: }
	addw	sp, #8
	ret
;	../rand.c: 53: void srand(unsigned int seed)
;	-----------------------------------------
;	 function srand
;	-----------------------------------------
_srand:
;	../rand.c: 55: s = seed | 0x80000000; /* s shall not become 0 */
	ldw	y, (0x03, sp)
	clrw	x
	sllw	x
	scf
	rrcw	x
	ldw	_s+2, y
	ldw	_s+0, x
;	../rand.c: 56: }
	ret
	.area CODE
	.area CONST
	.area INITIALIZER
__xinit__s:
	.byte #0x80, #0x00, #0x00, #0x01	; 2147483649
	.area CABS (ABS)
