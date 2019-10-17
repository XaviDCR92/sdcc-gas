;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module printf_large
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _strlen
	.globl __print_format
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
;	../printf_large.c: 116: output_digit (unsigned char n, bool lower_case, pfn_outputchar output_char, void* p)
;	-----------------------------------------
;	 function output_digit
;	-----------------------------------------
_output_digit:
;	../printf_large.c: 118: register unsigned char c = n + (unsigned char)'0';
	ld	a, (0x03, sp)
	add	a, #0x30
;	../printf_large.c: 120: if (c > (unsigned char)'9')
	cp	a, #0x39
	jrule	00104$
;	../printf_large.c: 122: c += (unsigned char)('A' - '0' - 10);
	add	a, #0x07
;	../printf_large.c: 123: if (lower_case)
	tnz	(0x04, sp)
	jreq	00104$
;	../printf_large.c: 124: c += (unsigned char)('a' - 'A');
	add	a, #0x20
00104$:
;	../printf_large.c: 126: output_char( c, p );
	ldw	x, (0x07, sp)
	pushw	x
	push	a
	ldw	x, (0x08, sp)
	call	(x)
	addw	sp, #3
;	../printf_large.c: 127: }
	ret
;	../printf_large.c: 149: output_2digits (unsigned char b, bool lower_case, pfn_outputchar output_char, void* p)
;	-----------------------------------------
;	 function output_2digits
;	-----------------------------------------
_output_2digits:
	push	a
;	../printf_large.c: 151: output_digit( b>>4,   lower_case, output_char, p );
	ld	a, (0x04, sp)
	swap	a
	and	a, #0x0f
	ld	(0x01, sp), a
	ldw	x, (0x08, sp)
	pushw	x
	ldw	x, (0x08, sp)
	pushw	x
	ld	a, (0x09, sp)
	push	a
	ld	a, (0x06, sp)
	push	a
	call	_output_digit
	addw	sp, #6
;	../printf_large.c: 152: output_digit( b&0x0F, lower_case, output_char, p );
	ld	a, (0x04, sp)
	and	a, #0x0f
	ld	(0x01, sp), a
	ldw	x, (0x08, sp)
	pushw	x
	ldw	x, (0x08, sp)
	pushw	x
	ld	a, (0x09, sp)
	push	a
	ld	a, (0x06, sp)
	push	a
	call	_output_digit
;	../printf_large.c: 153: }
	addw	sp, #7
	ret
;	../printf_large.c: 168: calculate_digit (value_t _AUTOMEM * value, unsigned char radix)
;	-----------------------------------------
;	 function calculate_digit
;	-----------------------------------------
_calculate_digit:
	sub	sp, #9
;	../printf_large.c: 170: unsigned long ul = value->ul;
	ldw	y, (0x0c, sp)
	ldw	(0x01, sp), y
	ldw	x, y
	ldw	y, (0x2, y)
	ldw	x, (x)
	ldw	(0x08, sp), y
	ldw	(0x06, sp), x
;	../printf_large.c: 171: unsigned char _AUTOMEM * pb4 = &value->byte[4];
	ldw	x, (0x01, sp)
	addw	x, #0x0004
	ldw	(0x03, sp), x
;	../printf_large.c: 172: unsigned char i = 32;
	ld	a, #0x20
	ld	(0x05, sp), a
;	../printf_large.c: 174: do
00103$:
;	../printf_large.c: 176: *pb4 = (*pb4 << 1) | ((ul >> 31) & 0x01);
	ldw	x, (0x03, sp)
	ld	a, (x)
	sll	a
	ld	xl, a
	ld	a, (0x06, sp)
	sll	a
	clr	a
	rlc	a
	pushw	x
	or	a, (2, sp)
	popw	x
	ldw	x, (0x03, sp)
	ld	(x), a
;	../printf_large.c: 177: ul <<= 1;
	sll	(0x09, sp)
	rlc	(0x08, sp)
	rlc	(0x07, sp)
	rlc	(0x06, sp)
;	../printf_large.c: 179: if (radix <= *pb4 )
	cp	a, (0x0e, sp)
	jrc	00104$
;	../printf_large.c: 181: *pb4 -= radix;
	ldw	x, (0x03, sp)
	ld	a, (x)
	sub	a, (0x0e, sp)
	ldw	x, (0x03, sp)
	ld	(x), a
;	../printf_large.c: 182: ul |= 1;
	ld	a, (0x09, sp)
	or	a, #0x01
	ld	yl, a
	ld	a, (0x08, sp)
	ld	yh, a
	ld	a, (0x07, sp)
	ld	xl, a
	ld	a, (0x06, sp)
	ld	xh, a
	ldw	(0x08, sp), y
	ldw	(0x06, sp), x
00104$:
;	../printf_large.c: 184: } while (--i);
	dec	(0x05, sp)
	jrne	00103$
;	../printf_large.c: 185: value->ul = ul;
	ldw	x, (0x01, sp)
	ldw	y, (0x08, sp)
	ldw	(0x2, x), y
	ldw	y, (0x06, sp)
	ldw	(x), y
;	../printf_large.c: 186: }
	addw	sp, #9
	ret
;	../printf_large.c: 434: _print_format (pfn_outputchar pfn, void* pvoid, const char *format, va_list ap)
;	-----------------------------------------
;	 function _print_format
;	-----------------------------------------
__print_format:
	sub	sp, #45
;	../printf_large.c: 466: charsOutputted = 0;
	clrw	x
	ldw	(0x10, sp), x
;	../printf_large.c: 475: while( c=*format++ )
	ldw	x, sp
	addw	x, #15
	ldw	(0x12, sp), x
	ldw	x, sp
	addw	x, #5
	ldw	(0x14, sp), x
	addw	x, #0x0004
	ldw	(0x16, sp), x
	ldw	(0x18, sp), x
	ldw	y, (0x16, sp)
	ldw	(0x1a, sp), y
00231$:
	ldw	x, (0x34, sp)
	ld	a, (x)
	incw	x
	ldw	(0x34, sp), x
	ld	(0x2d, sp), a
	jrne	00627$
	jp	00233$
00627$:
;	../printf_large.c: 477: if ( c=='%' )
	ld	a, (0x2d, sp)
	cp	a, #0x25
	jreq	00630$
	jp	00229$
00630$:
;	../printf_large.c: 479: left_justify    = 0;
	clr	(0x1c, sp)
;	../printf_large.c: 480: zero_padding    = 0;
	clr	(0x1d, sp)
;	../printf_large.c: 481: prefix_sign     = 0;
	clr	(0x1e, sp)
;	../printf_large.c: 482: prefix_space    = 0;
	clr	(0x1f, sp)
;	../printf_large.c: 483: signed_argument = 0;
	clr	(0x20, sp)
;	../printf_large.c: 484: char_argument   = 0;
	clr	(0x21, sp)
;	../printf_large.c: 485: long_argument   = 0;
	clr	(0x22, sp)
;	../printf_large.c: 486: float_argument  = 0;
	clr	(0x23, sp)
;	../printf_large.c: 487: radix           = 0;
	clr	(0x24, sp)
;	../printf_large.c: 488: width           = 0;
	clrw	x
	ldw	(0x25, sp), x
;	../printf_large.c: 489: decimals        = -1;
	ldw	x, #0xffff
	ldw	(0x2a, sp), x
;	../printf_large.c: 491: get_conversion_spec:
	ldw	y, (0x34, sp)
	ldw	(0x28, sp), y
00101$:
;	../printf_large.c: 493: c = *format++;
	ldw	x, (0x28, sp)
	ld	a, (x)
	ld	(0x2d, sp), a
	ldw	x, (0x28, sp)
	incw	x
	ldw	(0x28, sp), x
	ldw	(0x34, sp), x
;	../printf_large.c: 495: if (c=='%')
	ld	a, (0x2d, sp)
	cp	a, #0x25
	jrne	00103$
;	../printf_large.c: 497: OUTPUT_CHAR(c, p);
	ldw	x, (0x32, sp)
	pushw	x
	ld	a, (0x2f, sp)
	push	a
	ldw	x, (0x33, sp)
	call	(x)
	addw	sp, #3
	ldw	x, (0x10, sp)
	incw	x
	ldw	(0x10, sp), x
;	../printf_large.c: 498: continue;
	jra	00231$
00103$:
;	../printf_large.c: 501: if (isdigit(c))
	ld	a, (0x2d, sp)
	cp	a, #0x30
	jrc	00110$
	ld	a, (0x2d, sp)
	cp	a, #0x39
	jrugt	00110$
;	../printf_large.c: 503: if (decimals==-1)
	ldw	x, (0x2a, sp)
	incw	x
	jrne	00107$
;	../printf_large.c: 505: width = 10*width + c - '0';
	ldw	x, (0x25, sp)
	sllw	x
	sllw	x
	addw	x, (0x25, sp)
	sllw	x
	ldw	(0x03, sp), x
	clr	(0x2c, sp)
	ldw	x, (0x03, sp)
	addw	x, (0x2c, sp)
	ldw	(0x26, sp), x
	subw	x, #0x0030
	ldw	(0x2c, sp), x
;	../printf_large.c: 506: if (width == 0)
	ldw	(0x25, sp), x
	jrne	00101$
;	../printf_large.c: 509: zero_padding = 1;
	ld	a, #0x01
	ld	(0x1d, sp), a
	jra	00101$
00107$:
;	../printf_large.c: 514: decimals = 10*decimals + c - '0';
	ldw	x, (0x2a, sp)
	sllw	x
	sllw	x
	addw	x, (0x2a, sp)
	sllw	x
	ldw	(0x03, sp), x
	clr	(0x2c, sp)
	ldw	x, (0x03, sp)
	addw	x, (0x2c, sp)
	ldw	(0x2a, sp), x
	subw	x, #0x0030
	ldw	(0x2c, sp), x
	ldw	(0x2a, sp), x
;	../printf_large.c: 516: goto get_conversion_spec;
	jra	00101$
00110$:
;	../printf_large.c: 519: if (c=='.')
	ld	a, (0x2d, sp)
	cp	a, #0x2e
	jrne	00115$
;	../printf_large.c: 521: if (decimals==-1)
	ldw	x, (0x2a, sp)
	incw	x
	jreq	00646$
	jp	00101$
00646$:
;	../printf_large.c: 522: decimals=0;
	clrw	x
	ldw	(0x2a, sp), x
;	../printf_large.c: 525: goto get_conversion_spec;
	jp	00101$
00115$:
;	../printf_large.c: 528: if (islower(c))
	ld	a, (0x2d, sp)
	cp	a, #0x61
	jrc	00117$
	ld	a, (0x2d, sp)
	cp	a, #0x7a
	jrugt	00117$
;	../printf_large.c: 530: c = toupper(c);
	ld	a, (0x2d, sp)
	and	a, #0xdf
	ld	(0x2d, sp), a
;	../printf_large.c: 531: lower_case = 1;
	ld	a, #0x01
	ld	(0x27, sp), a
;	../printf_large.c: 534: lower_case = 0;
	.byte 0xc5
00117$:
	clr	(0x27, sp)
00118$:
;	../printf_large.c: 536: switch( c )
	ld	a, (0x2d, sp)
	cp	a, #0x20
	jrne	00650$
	jp	00122$
00650$:
	ld	a, (0x2d, sp)
	cp	a, #0x2b
	jrne	00653$
	jp	00121$
00653$:
	ld	a, (0x2d, sp)
	cp	a, #0x2d
	jrne	00656$
	jp	00120$
00656$:
	ld	a, (0x2d, sp)
	cp	a, #0x42
	jrne	00659$
	jp	00123$
00659$:
	ld	a, (0x2d, sp)
	cp	a, #0x43
	jrne	00662$
	jp	00129$
00662$:
	ld	a, (0x2d, sp)
	cp	a, #0x44
	jrne	00665$
	jp	00154$
00665$:
	ld	a, (0x2d, sp)
	cp	a, #0x46
	jrne	00668$
	jp	00158$
00668$:
	ld	a, (0x2d, sp)
	cp	a, #0x48
	jrne	00671$
	jp	00101$
00671$:
	ld	a, (0x2d, sp)
	cp	a, #0x49
	jrne	00674$
	jp	00154$
00674$:
	ld	a, (0x2d, sp)
	cp	a, #0x4a
	jrne	00677$
	jp	00101$
00677$:
	ld	a, (0x2d, sp)
	cp	a, #0x4c
	jreq	00128$
	ld	a, (0x2d, sp)
	cp	a, #0x4f
	jrne	00683$
	jp	00155$
00683$:
	ld	a, (0x2d, sp)
	cp	a, #0x50
	jrne	00686$
	jp	00152$
00686$:
	ld	a, (0x2d, sp)
	cp	a, #0x53
	jreq	00133$
	ld	a, (0x2d, sp)
	cp	a, #0x54
	jrne	00692$
	jp	00101$
00692$:
	ld	a, (0x2d, sp)
	cp	a, #0x55
	jrne	00695$
	jp	00156$
00695$:
	ld	a, (0x2d, sp)
	cp	a, #0x58
	jrne	00698$
	jp	00157$
00698$:
	ld	a, (0x2d, sp)
	cp	a, #0x5a
	jrne	00701$
	jp	00101$
00701$:
	jp	00159$
;	../printf_large.c: 538: case '-':
00120$:
;	../printf_large.c: 539: left_justify = 1;
	ld	a, #0x01
	ld	(0x1c, sp), a
;	../printf_large.c: 540: goto get_conversion_spec;
	jp	00101$
;	../printf_large.c: 541: case '+':
00121$:
;	../printf_large.c: 542: prefix_sign = 1;
	ld	a, #0x01
	ld	(0x1e, sp), a
;	../printf_large.c: 543: goto get_conversion_spec;
	jp	00101$
;	../printf_large.c: 544: case ' ':
00122$:
;	../printf_large.c: 545: prefix_space = 1;
	ld	a, #0x01
	ld	(0x1f, sp), a
;	../printf_large.c: 546: goto get_conversion_spec;
	jp	00101$
;	../printf_large.c: 547: case 'B': /* byte */
00123$:
;	../printf_large.c: 548: char_argument = 1;
	ld	a, #0x01
	ld	(0x21, sp), a
;	../printf_large.c: 549: goto get_conversion_spec;
	jp	00101$
;	../printf_large.c: 556: case 'L': /* long */
00128$:
;	../printf_large.c: 557: long_argument = 1;
	ld	a, #0x01
	ld	(0x22, sp), a
;	../printf_large.c: 558: goto get_conversion_spec;
	jp	00101$
;	../printf_large.c: 560: case 'C':
00129$:
;	../printf_large.c: 561: if( char_argument )
	tnz	(0x21, sp)
	jreq	00131$
;	../printf_large.c: 562: c = va_arg(ap,char);
	ldw	x, (0x36, sp)
	incw	x
	ldw	(0x36, sp), x
	addw	x, #0xffff
	ld	a, (x)
	jra	00132$
00131$:
;	../printf_large.c: 564: c = va_arg(ap,int);
	ldw	x, (0x36, sp)
	incw	x
	incw	x
	ldw	(0x36, sp), x
	decw	x
	decw	x
	ld	a, (0x1, x)
00132$:
;	../printf_large.c: 565: OUTPUT_CHAR( c, p );
	ldw	x, (0x32, sp)
	pushw	x
	push	a
	ldw	x, (0x33, sp)
	call	(x)
	addw	sp, #3
	ldw	x, (0x10, sp)
	incw	x
	ldw	(0x10, sp), x
;	../printf_large.c: 566: break;
	jp	00160$
;	../printf_large.c: 568: case 'S':
00133$:
;	../printf_large.c: 569: PTR = va_arg(ap,ptr_t);
	ldw	x, (0x36, sp)
	incw	x
	incw	x
	ldw	(0x36, sp), x
	decw	x
	decw	x
	ldw	x, (x)
	ldw	(0x05, sp), x
;	../printf_large.c: 582: length = strlen(PTR);
	pushw	x
	call	_strlen
	addw	sp, #2
	ldw	(0x28, sp), x
;	../printf_large.c: 584: if ( decimals == -1 )
	ldw	x, (0x2a, sp)
	incw	x
	jrne	00135$
;	../printf_large.c: 586: decimals = length;
	ldw	y, (0x28, sp)
	ldw	(0x2a, sp), y
00135$:
;	../printf_large.c: 588: if ( ( !left_justify ) && (length < width) )
	tnz	(0x1c, sp)
	jrne	00277$
	ldw	x, (0x28, sp)
	cpw	x, (0x25, sp)
	jrnc	00277$
;	../printf_large.c: 590: width -= length;
	ldw	x, (0x25, sp)
	subw	x, (0x28, sp)
;	../printf_large.c: 591: while( width-- != 0 )
	ldw	y, (0x10, sp)
	ldw	(0x25, sp), y
	ldw	(0x2c, sp), x
00136$:
	ldw	x, (0x2c, sp)
	ldw	y, (0x2c, sp)
	decw	y
	ldw	(0x2c, sp), y
	tnzw	x
	jreq	00312$
;	../printf_large.c: 593: OUTPUT_CHAR( ' ', p );
	ldw	x, (0x32, sp)
	pushw	x
	push	#0x20
	ldw	x, (0x33, sp)
	call	(x)
	addw	sp, #3
	ldw	x, (0x25, sp)
	incw	x
	ldw	(0x25, sp), x
	jra	00136$
;	../printf_large.c: 597: while ( (c = *PTR)  && (decimals-- > 0))
00312$:
	ldw	y, (0x25, sp)
	ldw	(0x10, sp), y
	ldw	y, (0x2c, sp)
	ldw	(0x25, sp), y
00277$:
	ldw	y, (0x10, sp)
	ldw	(0x2c, sp), y
00143$:
	ldw	x, (0x05, sp)
	ld	a, (x)
	ld	(0x11, sp), a
	jreq	00313$
	ldw	x, (0x2a, sp)
	cpw	x, #0x0000
	jrsle	00313$
	ldw	x, (0x2a, sp)
	decw	x
	ldw	(0x2a, sp), x
;	../printf_large.c: 599: OUTPUT_CHAR( c, p );
	ldw	x, (0x32, sp)
	pushw	x
	ld	a, (0x13, sp)
	push	a
	ldw	x, (0x33, sp)
	call	(x)
	addw	sp, #3
	ldw	x, (0x2c, sp)
	incw	x
	ldw	(0x2c, sp), x
;	../printf_large.c: 600: PTR++;
	ldw	x, (0x05, sp)
	incw	x
	ldw	(0x05, sp), x
	jra	00143$
00313$:
	ldw	y, (0x2c, sp)
	ldw	(0x10, sp), y
;	../printf_large.c: 603: if ( left_justify && (length < width))
	tnz	(0x1c, sp)
	jrne	00714$
	jp	00160$
00714$:
	ldw	x, (0x28, sp)
	cpw	x, (0x25, sp)
	jrc	00715$
	jp	00160$
00715$:
;	../printf_large.c: 605: width -= length;
	ldw	x, (0x25, sp)
	subw	x, (0x28, sp)
	ldw	(0x2a, sp), x
	ldw	(0x25, sp), x
;	../printf_large.c: 606: while( width-- != 0 )
	ldw	y, (0x2c, sp)
	ldw	(0x29, sp), y
	ldw	y, (0x25, sp)
	ldw	(0x2c, sp), y
00146$:
	ldw	x, (0x2c, sp)
	ldw	y, (0x2c, sp)
	decw	y
	ldw	(0x2c, sp), y
	tnzw	x
	jrne	00716$
	jp	00314$
00716$:
;	../printf_large.c: 608: OUTPUT_CHAR( ' ', p );
	ldw	x, (0x32, sp)
	pushw	x
	push	#0x20
	ldw	x, (0x33, sp)
	call	(x)
	addw	sp, #3
	ldw	x, (0x29, sp)
	incw	x
	ldw	(0x29, sp), x
	jra	00146$
;	../printf_large.c: 613: case 'P':
00152$:
;	../printf_large.c: 614: PTR = va_arg(ap,ptr_t);
	ldw	x, (0x36, sp)
	incw	x
	incw	x
	ldw	(0x2a, sp), x
	ldw	(0x36, sp), x
	ldw	x, (0x2a, sp)
	decw	x
	decw	x
	ldw	(0x2c, sp), x
	ldw	(0x2a, sp), x
	ldw	x, (x)
	ldw	(0x2c, sp), x
	ldw	(0x05, sp), x
;	../printf_large.c: 658: OUTPUT_CHAR('0', p);
	ldw	x, (0x32, sp)
	pushw	x
	push	#0x30
	ldw	x, (0x33, sp)
	call	(x)
	addw	sp, #3
	ldw	x, (0x10, sp)
	incw	x
	ldw	(0x2c, sp), x
	ldw	(0x2a, sp), x
;	../printf_large.c: 659: OUTPUT_CHAR('x', p);
	ldw	x, (0x32, sp)
	pushw	x
	push	#0x78
	ldw	x, (0x33, sp)
	call	(x)
	addw	sp, #3
	ldw	x, (0x2a, sp)
	incw	x
	ldw	(0x2c, sp), x
	ldw	(0x2a, sp), x
;	../printf_large.c: 660: OUTPUT_2DIGITS( value.byte[1] );
	ld	a, (0x06, sp)
	ld	(0x2d, sp), a
	ldw	x, (0x32, sp)
	pushw	x
	ldw	x, (0x32, sp)
	pushw	x
	ld	a, (0x2b, sp)
	push	a
	ld	a, (0x32, sp)
	push	a
	call	_output_2digits
	addw	sp, #6
	ldw	x, (0x2a, sp)
	incw	x
	incw	x
	ldw	(0x2c, sp), x
	ldw	(0x2a, sp), x
;	../printf_large.c: 661: OUTPUT_2DIGITS( value.byte[0] );
	ld	a, (0x05, sp)
	ld	(0x2d, sp), a
	ldw	x, (0x32, sp)
	pushw	x
	ldw	x, (0x32, sp)
	pushw	x
	ld	a, (0x2b, sp)
	push	a
	ld	a, (0x32, sp)
	push	a
	call	_output_2digits
	addw	sp, #6
	ldw	x, (0x2a, sp)
	incw	x
	incw	x
	ldw	(0x2c, sp), x
	ldw	(0x10, sp), x
;	../printf_large.c: 663: break;
	jra	00160$
;	../printf_large.c: 666: case 'I':
00154$:
;	../printf_large.c: 667: signed_argument = 1;
	ld	a, #0x01
	ld	(0x20, sp), a
;	../printf_large.c: 668: radix = 10;
	ld	a, #0x0a
	ld	(0x24, sp), a
;	../printf_large.c: 669: break;
	jra	00160$
;	../printf_large.c: 671: case 'O':
00155$:
;	../printf_large.c: 672: radix = 8;
	ld	a, #0x08
	ld	(0x24, sp), a
;	../printf_large.c: 673: break;
	jra	00160$
;	../printf_large.c: 675: case 'U':
00156$:
;	../printf_large.c: 676: radix = 10;
	ld	a, #0x0a
	ld	(0x24, sp), a
;	../printf_large.c: 677: break;
	jra	00160$
;	../printf_large.c: 679: case 'X':
00157$:
;	../printf_large.c: 680: radix = 16;
	ld	a, #0x10
	ld	(0x24, sp), a
;	../printf_large.c: 681: break;
	jra	00160$
;	../printf_large.c: 683: case 'F':
00158$:
;	../printf_large.c: 684: float_argument=1;
	ld	a, #0x01
	ld	(0x23, sp), a
;	../printf_large.c: 685: break;
	jra	00160$
;	../printf_large.c: 687: default:
00159$:
;	../printf_large.c: 689: OUTPUT_CHAR( c, p );
	ldw	x, (0x32, sp)
	pushw	x
	ld	a, (0x2f, sp)
	push	a
	ldw	x, (0x33, sp)
	call	(x)
	addw	sp, #3
	ldw	x, (0x10, sp)
	incw	x
	ldw	(0x2c, sp), x
	ldw	(0x10, sp), x
;	../printf_large.c: 872: return charsOutputted;
	jra	00160$
;	../printf_large.c: 691: }
00314$:
	ldw	y, (0x29, sp)
	ldw	(0x10, sp), y
	ldw	y, (0x2c, sp)
	ldw	(0x25, sp), y
00160$:
;	../printf_large.c: 693: if (float_argument)
	tnz	(0x23, sp)
	jreq	00226$
;	../printf_large.c: 695: value.f = va_arg(ap, float);
	ldw	x, (0x36, sp)
	addw	x, #0x0004
	ldw	(0x36, sp), x
	subw	x, #0x0004
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	x, (x)
	ldw	(0x07, sp), y
	ldw	(0x05, sp), x
;	../printf_large.c: 697: PTR="<NO FLOAT>";
	ldw	x, #(___str_0 + 0)
	ldw	(0x05, sp), x
;	../printf_large.c: 698: while (c=*PTR++)
	ldw	y, (0x10, sp)
	ldw	(0x2c, sp), y
00161$:
	ldw	y, (0x05, sp)
	ldw	(0x28, sp), y
	ldw	x, y
	incw	x
	ldw	(0x2a, sp), x
	ldw	(0x05, sp), x
	ldw	x, (0x28, sp)
	ld	a, (x)
	ld	xl, a
	tnz	a
	jrne	00719$
	jp	00231$
00719$:
;	../printf_large.c: 700: OUTPUT_CHAR (c, p);
	ldw	y, (0x32, sp)
	pushw	y
	ld	a, xl
	push	a
	ldw	x, (0x33, sp)
	call	(x)
	addw	sp, #3
	ldw	x, (0x2c, sp)
	incw	x
	ldw	(0x2c, sp), x
	ldw	(0x10, sp), x
	jra	00161$
00226$:
;	../printf_large.c: 718: else if (radix != 0)
	tnz	(0x24, sp)
	jrne	00721$
	jp	00231$
00721$:
;	../printf_large.c: 723: unsigned char MEM_SPACE_BUF_PP *pstore = &store[5];
	ldw	x, (0x12, sp)
	ldw	(0x2b, sp), x
;	../printf_large.c: 726: if (char_argument)
	tnz	(0x21, sp)
	jreq	00172$
;	../printf_large.c: 728: value.l = va_arg(ap, char);
	ldw	x, (0x36, sp)
	incw	x
	ldw	(0x36, sp), x
	addw	x, #0xffff
	ld	a, (x)
	clrw	x
	ld	xl, a
	clrw	y
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
;	../printf_large.c: 729: if (!signed_argument)
	tnz	(0x20, sp)
	jrne	00173$
;	../printf_large.c: 731: value.l &= 0xFF;
	ldw	x, (0x07, sp)
	clr	a
	ld	xh, a
	clrw	y
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
	jra	00173$
00172$:
;	../printf_large.c: 734: else if (long_argument)
	tnz	(0x22, sp)
	jreq	00169$
;	../printf_large.c: 736: value.l = va_arg(ap, long);
	ldw	x, (0x36, sp)
	addw	x, #0x0004
	ldw	(0x36, sp), x
	subw	x, #0x0004
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	x, (x)
	ldw	(0x07, sp), y
	ldw	(0x05, sp), x
	jra	00173$
00169$:
;	../printf_large.c: 740: value.l = va_arg(ap, int);
	ldw	x, (0x36, sp)
	incw	x
	incw	x
	ldw	(0x36, sp), x
	decw	x
	decw	x
	ldw	x, (x)
	clrw	y
	tnzw	x
	jrpl	00725$
	decw	y
00725$:
	ldw	(0x07, sp), x
	ldw	(0x05, sp), y
;	../printf_large.c: 741: if (!signed_argument)
	tnz	(0x20, sp)
	jrne	00173$
;	../printf_large.c: 743: value.l &= 0xFFFF;
	ldw	y, (0x07, sp)
	clrw	x
	ldw	(0x07, sp), y
	ldw	(0x05, sp), x
00173$:
;	../printf_large.c: 747: if ( signed_argument )
	tnz	(0x20, sp)
	jreq	00178$
;	../printf_large.c: 749: if (value.l < 0)
	ldw	x, (0x05, sp)
	jrpl	00175$
;	../printf_large.c: 750: value.l = -value.l;
	ldw	y, (0x07, sp)
	ldw	(0x03, sp), y
	ldw	y, (0x05, sp)
	ldw	(0x01, sp), y
	ldw	y, (0x03, sp)
	negw	y
	ldw	x, (0x01, sp)
	jrnc	00729$
	incw	x
00729$:
	negw	x
	ldw	(0x07, sp), y
	ldw	(0x05, sp), x
;	../printf_large.c: 752: signed_argument = 0;
	.byte 0xc5
00175$:
	clr	(0x20, sp)
00178$:
;	../printf_large.c: 756: lsd = 1;
	ld	a, #0x01
	ld	(0x2d, sp), a
;	../printf_large.c: 758: do {
	ldw	y, (0x2b, sp)
	ldw	(0x29, sp), y
	clrw	x
	ldw	(0x2b, sp), x
00182$:
;	../printf_large.c: 759: value.byte[4] = 0;
	clr	(0x09, sp)
;	../printf_large.c: 761: calculate_digit(&value, radix);
	ldw	x, (0x14, sp)
	ld	a, (0x24, sp)
	push	a
	pushw	x
	call	_calculate_digit
	addw	sp, #3
;	../printf_large.c: 765: if (!lsd)
	tnz	(0x2d, sp)
	jrne	00180$
;	../printf_large.c: 767: *pstore = (value.byte[4] << 4) | (value.byte[4] >> 4) | *pstore;
	ldw	x, (0x18, sp)
	ld	a, (x)
	swap	a
	and	a, #0xf0
	ld	xl, a
	ldw	y, (0x18, sp)
	ld	a, (y)
	swap	a
	and	a, #0x0f
	pushw	x
	or	a, (2, sp)
	popw	x
	ld	(0x28, sp), a
	ldw	x, (0x29, sp)
	ld	a, (x)
	or	a, (0x28, sp)
	ldw	x, (0x29, sp)
	ld	(x), a
;	../printf_large.c: 768: pstore--;
	ldw	x, (0x29, sp)
	decw	x
	ldw	(0x29, sp), x
	jra	00181$
00180$:
;	../printf_large.c: 772: *pstore = value.byte[4];
	ldw	x, (0x16, sp)
	ld	a, (x)
	ldw	x, (0x29, sp)
	ld	(x), a
00181$:
;	../printf_large.c: 774: length++;
	ldw	x, (0x2b, sp)
	incw	x
	ldw	(0x2b, sp), x
;	../printf_large.c: 775: lsd = !lsd;
	ld	a, (0x2d, sp)
	sub	a, #0x01
	clr	a
	rlc	a
	ld	(0x2d, sp), a
;	../printf_large.c: 776: } while( value.ul );
	ldw	x, (0x14, sp)
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	(0x03, sp), y
	ldw	x, (x)
	ldw	(0x01, sp), x
	ldw	x, (0x03, sp)
	jrne	00182$
	ldw	x, (0x01, sp)
	jrne	00182$
;	../printf_large.c: 778: if (width == 0)
	ldw	y, (0x29, sp)
	ldw	(0x21, sp), y
	ldw	y, (0x2b, sp)
	ldw	(0x23, sp), y
	ldw	x, (0x25, sp)
	jrne	00186$
;	../printf_large.c: 783: width = 1;
	ldw	x, #0x0001
	ldw	(0x25, sp), x
00186$:
;	../printf_large.c: 787: if (!zero_padding && !left_justify)
	tnz	(0x1d, sp)
	jrne	00191$
	tnz	(0x1c, sp)
	jrne	00191$
;	../printf_large.c: 789: while ( width > (unsigned char) (length+1) )
	ldw	y, (0x10, sp)
	ldw	(0x29, sp), y
	ldw	y, (0x25, sp)
	ldw	(0x2b, sp), y
00187$:
	ld	a, (0x24, sp)
	inc	a
	clrw	x
	ld	xl, a
	cpw	x, (0x2b, sp)
	jrnc	00316$
;	../printf_large.c: 791: OUTPUT_CHAR( ' ', p );
	ldw	x, (0x32, sp)
	pushw	x
	push	#0x20
	ldw	x, (0x33, sp)
	call	(x)
	addw	sp, #3
	ldw	x, (0x29, sp)
	incw	x
	ldw	(0x29, sp), x
;	../printf_large.c: 792: width--;
	ldw	x, (0x2b, sp)
	decw	x
	ldw	(0x2b, sp), x
	jra	00187$
00316$:
	ldw	y, (0x29, sp)
	ldw	(0x10, sp), y
	ldw	y, (0x2b, sp)
	ldw	(0x25, sp), y
00191$:
;	../printf_large.c: 796: if (signed_argument) // this now means the original value was negative
	tnz	(0x20, sp)
	jreq	00201$
;	../printf_large.c: 798: OUTPUT_CHAR( '-', p );
	ldw	x, (0x32, sp)
	pushw	x
	push	#0x2d
	ldw	x, (0x33, sp)
	call	(x)
	addw	sp, #3
	ldw	x, (0x10, sp)
	incw	x
	ldw	(0x10, sp), x
;	../printf_large.c: 800: width--;
	ldw	x, (0x25, sp)
	decw	x
	ldw	(0x25, sp), x
	jra	00202$
00201$:
;	../printf_large.c: 802: else if (length != 0)
	ldw	x, (0x23, sp)
	jreq	00202$
;	../printf_large.c: 805: if (prefix_sign)
	tnz	(0x1e, sp)
	jreq	00196$
;	../printf_large.c: 807: OUTPUT_CHAR( '+', p );
	ldw	x, (0x32, sp)
	pushw	x
	push	#0x2b
	ldw	x, (0x33, sp)
	call	(x)
	addw	sp, #3
	ldw	x, (0x10, sp)
	incw	x
	ldw	(0x10, sp), x
;	../printf_large.c: 809: width--;
	ldw	x, (0x25, sp)
	decw	x
	ldw	(0x25, sp), x
	jra	00202$
00196$:
;	../printf_large.c: 811: else if (prefix_space)
	tnz	(0x1f, sp)
	jreq	00202$
;	../printf_large.c: 813: OUTPUT_CHAR( ' ', p );
	ldw	x, (0x32, sp)
	pushw	x
	push	#0x20
	ldw	x, (0x33, sp)
	call	(x)
	addw	sp, #3
	ldw	x, (0x10, sp)
	incw	x
	ldw	(0x10, sp), x
;	../printf_large.c: 815: width--;
	ldw	x, (0x25, sp)
	decw	x
	ldw	(0x25, sp), x
00202$:
;	../printf_large.c: 820: if (!left_justify)
	tnz	(0x1c, sp)
	jrne	00210$
;	../printf_large.c: 822: while ( width-- > length )
	ldw	y, (0x10, sp)
	ldw	(0x29, sp), y
	ldw	y, (0x25, sp)
	ldw	(0x2b, sp), y
00203$:
	ldw	y, (0x2b, sp)
	ldw	x, (0x2b, sp)
	decw	x
	ldw	(0x2b, sp), x
	ldw	x, y
	cpw	x, (0x23, sp)
	jrule	00317$
;	../printf_large.c: 824: OUTPUT_CHAR( zero_padding ? '0' : ' ', p );
	tnz	(0x1d, sp)
	jreq	00236$
	ldw	x, #0x0030
	.byte 0xbc
00236$:
	ldw	x, #0x0020
00237$:
	ld	a, xl
	ldw	x, (0x32, sp)
	pushw	x
	push	a
	ldw	x, (0x33, sp)
	call	(x)
	addw	sp, #3
	ldw	x, (0x29, sp)
	incw	x
	ldw	(0x29, sp), x
	jra	00203$
00210$:
;	../printf_large.c: 830: if (width > length)
	ldw	x, (0x25, sp)
	cpw	x, (0x23, sp)
	jrule	00207$
;	../printf_large.c: 831: width -= length;
	ldw	x, (0x25, sp)
	subw	x, (0x23, sp)
	ldw	(0x28, sp), x
	jra	00309$
00207$:
;	../printf_large.c: 833: width = 0;
	clrw	x
	ldw	(0x28, sp), x
;	../printf_large.c: 872: return charsOutputted;
	jra	00309$
;	../printf_large.c: 837: while( length-- )
00317$:
	ldw	y, (0x29, sp)
	ldw	(0x10, sp), y
	ldw	y, (0x2b, sp)
	ldw	(0x28, sp), y
00309$:
	ldw	y, (0x21, sp)
	ldw	(0x2b, sp), y
	ldw	y, (0x10, sp)
	ldw	(0x25, sp), y
00215$:
	ldw	x, (0x23, sp)
	ldw	y, (0x23, sp)
	decw	y
	ldw	(0x23, sp), y
	tnzw	x
	jreq	00318$
;	../printf_large.c: 839: lsd = !lsd;
	ld	a, (0x2d, sp)
	sub	a, #0x01
	clr	a
	rlc	a
;	../printf_large.c: 840: if (!lsd)
	ld	(0x2d, sp), a
	jrne	00213$
;	../printf_large.c: 842: pstore++;
	ldw	x, (0x2b, sp)
	incw	x
;	../printf_large.c: 843: value.byte[4] = *pstore >> 4;
	ldw	(0x2b, sp), x
	ld	a, (x)
	swap	a
	and	a, #0x0f
	ldw	x, (0x16, sp)
	ld	(x), a
	jra	00214$
00213$:
;	../printf_large.c: 847: value.byte[4] = *pstore & 0x0F;
	ldw	x, (0x2b, sp)
	ld	a, (x)
	and	a, #0x0f
	ldw	x, (0x16, sp)
	ld	(x), a
00214$:
;	../printf_large.c: 850: output_digit( value.byte[4], lower_case, output_char, p );
	ldw	x, (0x1a, sp)
	ld	a, (x)
	ld	(0x2a, sp), a
	ldw	x, (0x32, sp)
	pushw	x
	ldw	x, (0x32, sp)
	pushw	x
	ld	a, (0x2b, sp)
	push	a
	ld	a, (0x2f, sp)
	push	a
	call	_output_digit
	addw	sp, #6
;	../printf_large.c: 851: charsOutputted++;
	ldw	x, (0x25, sp)
	incw	x
	ldw	(0x25, sp), x
	jra	00215$
00318$:
	ldw	y, (0x25, sp)
	ldw	(0x10, sp), y
;	../printf_large.c: 856: if (left_justify)
	tnz	(0x1c, sp)
	jrne	00752$
	jp	00231$
00752$:
;	../printf_large.c: 858: while (width-- > 0)
	ldw	y, (0x25, sp)
	ldw	(0x2c, sp), y
	ldw	y, (0x28, sp)
	ldw	(0x2a, sp), y
00218$:
	ldw	x, (0x2a, sp)
	ldw	y, (0x2a, sp)
	decw	y
	ldw	(0x2a, sp), y
	tnzw	x
	jrne	00753$
	jp	00231$
00753$:
;	../printf_large.c: 860: OUTPUT_CHAR(' ', p);
	ldw	x, (0x32, sp)
	pushw	x
	push	#0x20
	ldw	x, (0x33, sp)
	call	(x)
	addw	sp, #3
	ldw	x, (0x2c, sp)
	incw	x
	ldw	(0x2c, sp), x
	ldw	(0x10, sp), x
	jra	00218$
00229$:
;	../printf_large.c: 868: OUTPUT_CHAR( c, p );
	ldw	x, (0x32, sp)
	pushw	x
	ld	a, (0x2f, sp)
	push	a
	ldw	x, (0x33, sp)
	call	(x)
	addw	sp, #3
	ldw	x, (0x10, sp)
	incw	x
	ldw	(0x10, sp), x
	jp	00231$
00233$:
;	../printf_large.c: 872: return charsOutputted;
	ldw	x, (0x10, sp)
;	../printf_large.c: 873: }
	addw	sp, #45
	ret
	.area CODE
	.area CONST
	.area CONST
___str_0:
	.ascii "<NO FLOAT>"
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
