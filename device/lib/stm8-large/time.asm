;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 3.9.3 #11345 (Linux)
;--------------------------------------------------------
	.module time
	.optsdcc -mstm8
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl ___day
	.globl ___month
	.globl _RtcRead
	.globl _sprintf
	.globl _time
	.globl _asctime
	.globl _ctime
	.globl _localtime
	.globl _gmtime
	.globl _mktime
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area DATA
_ascTimeBuffer:
	.ds 32
_lastTime:
	.ds 12
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
;	../time.c: 42: unsigned char RtcRead(struct tm *timeptr) {
;	-----------------------------------------
;	 function RtcRead
;	-----------------------------------------
_RtcRead:
;	../time.c: 45: return 0;
	clr	a
;	../time.c: 46: }
	retf
;	../time.c: 50: time_t time(time_t *timeptr) {
;	-----------------------------------------
;	 function time
;	-----------------------------------------
_time:
	sub	sp, #16
;	../time.c: 52: time_t t=(time_t) -1;
	ldw	x, #0xffff
	ldw	(0x0f, sp), x
	ldw	x, #0xffff
	ldw	(0x0d, sp), x
;	../time.c: 54: if (RtcRead(&now)) {
	ldw	x, sp
	incw	x
	ldw	y, x
	pushw	x
	pushw	y
	callf	_RtcRead
	addw	sp, #2
	popw	x
	tnz	a
	jreq	00102$
;	../time.c: 55: t=mktime(&now);
	pushw	x
	callf	_mktime
	addw	sp, #2
	ldw	(0x0f, sp), x
	ldw	(0x0d, sp), y
00102$:
;	../time.c: 57: if (timeptr) {
;	../time.c: 58: *timeptr=t;
	ldw	x, (0x14, sp)
	jreq	00104$
	ldw	y, (0x0f, sp)
	ldw	(0x2, x), y
	ldw	y, (0x0d, sp)
	ldw	(x), y
00104$:
;	../time.c: 60: return t;
	ldw	x, (0x0f, sp)
	ldw	y, (0x0d, sp)
;	../time.c: 61: }
	addw	sp, #16
	retf
;	../time.c: 73: static void CheckTime(struct tm *timeptr) {
;	-----------------------------------------
;	 function CheckTime
;	-----------------------------------------
_CheckTime:
;	../time.c: 84: if (timeptr->tm_sec>59) timeptr->tm_sec=59;
	ldw	y, (0x04, sp)
	ld	a, (y)
	cp	a, #0x3b
	jrule	00102$
	ld	a, #0x3b
	ld	(y), a
00102$:
;	../time.c: 85: if (timeptr->tm_min>59) timeptr->tm_min=59;
	ldw	x, y
	incw	x
	ld	a, (x)
	cp	a, #0x3b
	jrule	00104$
	ld	a, #0x3b
	ld	(x), a
00104$:
;	../time.c: 86: if (timeptr->tm_hour>23) timeptr->tm_hour=23;
	ldw	x, y
	incw	x
	incw	x
	ld	a, (x)
	cp	a, #0x17
	jrule	00106$
	ld	a, #0x17
	ld	(x), a
00106$:
;	../time.c: 87: if (timeptr->tm_wday>6) timeptr->tm_wday=6;
	ldw	x, y
	addw	x, #0x0007
	ld	a, (x)
	cp	a, #0x06
	jrule	00108$
	ld	a, #0x06
	ld	(x), a
00108$:
;	../time.c: 88: if (timeptr->tm_mday<1) timeptr->tm_mday=1;
	ldw	x, y
	addw	x, #0x0003
	ld	a, (x)
	cp	a, #0x01
	jrnc	00112$
	ld	a, #0x01
	ld	(x), a
	jra	00113$
00112$:
;	../time.c: 89: else if (timeptr->tm_mday>31) timeptr->tm_mday=31;
	cp	a, #0x1f
	jrule	00113$
	ld	a, #0x1f
	ld	(x), a
00113$:
;	../time.c: 90: if (timeptr->tm_mon>11) timeptr->tm_mon=11;
	ldw	x, y
	addw	x, #0x0004
	ld	a, (x)
	cp	a, #0x0b
	jrule	00115$
	ld	a, #0x0b
	ld	(x), a
00115$:
;	../time.c: 91: if (timeptr->tm_year<0) timeptr->tm_year=0;
	addw	y, #0x0005
	ldw	x, y
	ldw	x, (x)
	jrpl	00118$
	ldw	x, y
	clr	(0x1, x)
	clr	(x)
00118$:
;	../time.c: 92: }
	retf
;	../time.c: 95: char *asctime(struct tm *timeptr) {
;	-----------------------------------------
;	 function asctime
;	-----------------------------------------
_asctime:
	sub	sp, #12
;	../time.c: 96: CheckTime(timeptr);
	ldw	x, (0x10, sp)
	pushw	x
	callf	_CheckTime
	addw	sp, #2
;	../time.c: 100: timeptr->tm_year+1900);
	ldw	y, (0x10, sp)
	ldw	x, y
	ldw	x, (0x5, x)
	addw	x, #0x076c
	ldw	(0x01, sp), x
;	../time.c: 99: timeptr->tm_hour, timeptr->tm_min, timeptr->tm_sec, 
	ld	a, (y)
	ld	(0x04, sp), a
	clr	(0x03, sp)
	ldw	x, y
	ld	a, (0x1, x)
	ld	(0x06, sp), a
	clr	(0x05, sp)
	ldw	x, y
	ld	a, (0x2, x)
	ld	(0x08, sp), a
	clr	(0x07, sp)
;	../time.c: 98: __day[timeptr->tm_wday], __month[timeptr->tm_mon], timeptr->tm_mday,
	ldw	x, y
	ld	a, (0x3, x)
	ld	(0x0a, sp), a
	clr	(0x09, sp)
	ldw	x, y
	ld	a, (0x4, x)
	clrw	x
	ld	xl, a
	sllw	x
	addw	x, #(___month + 0)
	clr	a
	adc	a, #((___month + 0) >> 16)
	ldw	x, (x)
	ldw	(0x0b, sp), x
	ld	a, (0x7, y)
	clrw	x
	ld	xl, a
	sllw	x
	addw	x, #(___day + 0)
	clr	a
	adc	a, #((___day + 0) >> 16)
	ldw	x, (x)
	ldw	y, x
;	../time.c: 97: sprintf (ascTimeBuffer, "%s %s %2d %02d:%02d:%02d %04d\n",
	ldw	x, (0x01, sp)
	pushw	x
	ldw	x, (0x05, sp)
	pushw	x
	ldw	x, (0x09, sp)
	pushw	x
	ldw	x, (0x0d, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x15, sp)
	pushw	x
	pushw	y
	push	#<(___str_0 + 0)
	push	#((___str_0 + 0) >> 8)
	push	#<(_ascTimeBuffer + 0)
	push	#((_ascTimeBuffer + 0) >> 8)
	callf	_sprintf
	addw	sp, #18
;	../time.c: 101: return ascTimeBuffer;
	ldw	x, #(_ascTimeBuffer + 0)
;	../time.c: 102: }
	addw	sp, #12
	retf
;	../time.c: 104: char *ctime(time_t *timep) {
;	-----------------------------------------
;	 function ctime
;	-----------------------------------------
_ctime:
;	../time.c: 105: return asctime(localtime(timep));
	ldw	x, (0x04, sp)
	pushw	x
	callf	_localtime
	addw	sp, #2
	pushw	x
	callf	_asctime
	addw	sp, #2
;	../time.c: 106: }
	retf
;	../time.c: 121: struct tm *localtime(time_t *timep) {
;	-----------------------------------------
;	 function localtime
;	-----------------------------------------
_localtime:
;	../time.c: 122: return gmtime(timep);
	ldw	x, (0x04, sp)
	pushw	x
	callf	_gmtime
	addw	sp, #2
;	../time.c: 123: }
	retf
;	../time.c: 125: struct tm *gmtime(time_t *timep) {
;	-----------------------------------------
;	 function gmtime
;	-----------------------------------------
_gmtime:
	sub	sp, #16
;	../time.c: 126: unsigned long epoch=*timep;
	ldw	x, (0x14, sp)
	ldw	y, x
	ldw	y, (0x2, y)
	ldw	x, (x)
	ldw	(0x0f, sp), y
	ldw	(0x0d, sp), x
;	../time.c: 131: lastTime.tm_sec=epoch%60;
	push	#0x3c
	clrw	x
	pushw	x
	push	#0x00
	ldw	x, (0x13, sp)
	pushw	x
	ldw	x, (0x13, sp)
	pushw	x
	callf	__modulong
	addw	sp, #8
	ld	a, xl
	ld	_lastTime+0, a
;	../time.c: 132: epoch/=60; // now it is minutes
	push	#0x3c
	clrw	x
	pushw	x
	push	#0x00
	ldw	x, (0x13, sp)
	pushw	x
	ldw	x, (0x13, sp)
	pushw	x
	callf	__divulong
	addw	sp, #8
	ldw	(0x0d, sp), x
	ldw	(0x0b, sp), y
;	../time.c: 133: lastTime.tm_min=epoch%60;
	ldw	x, #(_lastTime + 0)+1
	ldw	(0x0f, sp), x
	push	#0x3c
	clrw	x
	pushw	x
	push	#0x00
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	callf	__modulong
	addw	sp, #8
	ld	a, xl
	ldw	x, (0x0f, sp)
	ld	(x), a
;	../time.c: 134: epoch/=60; // now it is hours
	push	#0x3c
	clrw	x
	pushw	x
	push	#0x00
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	callf	__divulong
	addw	sp, #8
	ldw	(0x0d, sp), x
	ldw	(0x0b, sp), y
;	../time.c: 135: lastTime.tm_hour=epoch%24;
	ldw	x, #(_lastTime + 0)+2
	ldw	(0x0f, sp), x
	push	#0x18
	clrw	x
	pushw	x
	push	#0x00
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	callf	__modulong
	addw	sp, #8
	ld	a, xl
	ldw	x, (0x0f, sp)
	ld	(x), a
;	../time.c: 136: epoch/=24; // now it is days
	push	#0x18
	clrw	x
	pushw	x
	push	#0x00
	ldw	x, (0x11, sp)
	pushw	x
	ldw	x, (0x11, sp)
	pushw	x
	callf	__divulong
	addw	sp, #8
	ldw	(0x03, sp), x
	ldw	(0x01, sp), y
;	../time.c: 137: lastTime.tm_wday=(epoch+4)%7;
	ldw	x, #(_lastTime + 0)+7
	ldw	(0x0f, sp), x
	ldw	x, (0x03, sp)
	addw	x, #0x0004
	ldw	y, (0x01, sp)
	jrnc	00164$
	incw	y
00164$:
	push	#0x07
	push	#0x00
	push	#0x00
	push	#0x00
	pushw	x
	pushw	y
	callf	__modulong
	addw	sp, #8
	ld	a, xl
	ldw	x, (0x0f, sp)
	ld	(x), a
;	../time.c: 140: days=0;
	clrw	x
	ldw	(0x07, sp), x
	ldw	(0x05, sp), x
;	../time.c: 141: while((days += (LEAP_YEAR(year) ? 366 : 365)) <= epoch) {
	ldw	x, #0x07b2
	ldw	(0x0f, sp), x
00101$:
	ld	a, (0x10, sp)
	and	a, #0x03
	ld	(0x0a, sp), a
	clr	(0x09, sp)
	ldw	x, (0x09, sp)
	jrne	00118$
	ldw	x, #0x016e
	ldw	(0x0d, sp), x
	jra	00119$
00118$:
	ldw	x, #0x016d
	ldw	(0x0d, sp), x
00119$:
	ldw	y, (0x0d, sp)
	clrw	x
	tnzw	y
	jrpl	00166$
	decw	x
00166$:
	addw	y, (0x07, sp)
	ldw	(0x0d, sp), y
	ld	a, xl
	adc	a, (0x06, sp)
	ld	(0x0c, sp), a
	ld	a, xh
	adc	a, (0x05, sp)
	ld	(0x0b, sp), a
	ldw	y, (0x0d, sp)
	ldw	(0x07, sp), y
	ldw	y, (0x0b, sp)
	ldw	(0x05, sp), y
	ldw	x, (0x03, sp)
	cpw	x, (0x0d, sp)
	ld	a, (0x02, sp)
	sbc	a, (0x0c, sp)
	ld	a, (0x01, sp)
	sbc	a, (0x0b, sp)
	jrc	00103$
;	../time.c: 142: year++;
	ldw	x, (0x0f, sp)
	incw	x
	ldw	(0x0f, sp), x
	jra	00101$
00103$:
;	../time.c: 144: lastTime.tm_year=year-1900;
	ldw	x, #(_lastTime + 0)+5
	ldw	y, (0x0f, sp)
	subw	y, #0x076c
	ldw	(x), y
;	../time.c: 146: days -= LEAP_YEAR(year) ? 366 : 365;
	ldw	y, (0x09, sp)
	ldw	(0x0f, sp), y
	ldw	x, (0x09, sp)
	jrne	00120$
	ldw	x, #0x016e
	.byte 0xbc
00120$:
	ldw	x, #0x016d
00121$:
	ldw	(0x0d, sp), x
	clrw	x
	tnz	(0x0d, sp)
	jrpl	00170$
	decw	x
00170$:
	ldw	y, (0x07, sp)
	subw	y, (0x0d, sp)
	ld	a, (0x06, sp)
	pushw	x
	sbc	a, (#2, sp)
	popw	x
	ld	xl, a
	ld	a, (0x05, sp)
	pushw	x
	sbc	a, (#1, sp)
	popw	x
	ldw	(0x0d, sp), y
;	../time.c: 147: epoch -= days; // now it is days in this year, starting at 0
	ldw	y, (0x03, sp)
	subw	y, (0x0d, sp)
	push	a
	ld	a, (0x03, sp)
	pushw	x
	sbc	a, (#2, sp)
	popw	x
	ld	xl, a
	ld	a, (0x02, sp)
	sbc	a, (1, sp)
	ld	xh, a
	pop	a
	ldw	(0x08, sp), y
	ldw	(0x06, sp), x
;	../time.c: 148: lastTime.tm_yday=epoch;
	ldw	x, #(_lastTime + 0)+8
	ldw	y, (0x08, sp)
	ldw	(x), y
;	../time.c: 153: for (month=0; month<12; month++) {
	clr	(0x0e, sp)
00114$:
;	../time.c: 154: if (month==1) { // februari
	ld	a, (0x0e, sp)
	dec	a
	jrne	00108$
;	../time.c: 155: if (LEAP_YEAR(year)) {
	ldw	x, (0x0f, sp)
	jrne	00105$
;	../time.c: 156: monthLength=29;
	ld	a, #0x1d
	jra	00109$
00105$:
;	../time.c: 158: monthLength=28;
	ld	a, #0x1c
	jra	00109$
00108$:
;	../time.c: 161: monthLength = monthDays[month];
	clrw	x
	ld	a, (0x0e, sp)
	ld	xl, a
	addw	x, #(_monthDays + 0)
	ldw	(0x0c, sp), x
	clr	a
	adc	a, #((_monthDays + 0) >> 16)
	ldw	x, (0x0c, sp)
	ld	a, (x)
00109$:
;	../time.c: 164: if (epoch>=monthLength) {
	ld	(0x0d, sp), a
	clr	(0x0c, sp)
	clr	(0x0b, sp)
	clr	(0x0a, sp)
	ldw	x, (0x08, sp)
	cpw	x, (0x0c, sp)
	ld	a, (0x07, sp)
	sbc	a, (0x0b, sp)
	ld	a, (0x06, sp)
	sbc	a, (0x0a, sp)
	jrc	00113$
;	../time.c: 165: epoch-=monthLength;
	ldw	y, (0x08, sp)
	subw	y, (0x0c, sp)
	ld	a, (0x07, sp)
	sbc	a, (0x0b, sp)
	ld	xl, a
	ld	a, (0x06, sp)
	sbc	a, (0x0a, sp)
	ld	xh, a
	ldw	(0x08, sp), y
	ldw	(0x06, sp), x
;	../time.c: 153: for (month=0; month<12; month++) {
	inc	(0x0e, sp)
	ld	a, (0x0e, sp)
	cp	a, #0x0c
	jrc	00114$
00113$:
;	../time.c: 170: lastTime.tm_mon=month;
	ldw	x, #(_lastTime + 0)+4
	ld	a, (0x0e, sp)
	ld	(x), a
;	../time.c: 171: lastTime.tm_mday=epoch+1;
	ldw	x, #(_lastTime + 0)+3
	ld	a, (0x09, sp)
	inc	a
	ld	(x), a
;	../time.c: 173: lastTime.tm_isdst=0;
	ldw	x, #(_lastTime + 0)+10
	clr	(x)
;	../time.c: 175: return &lastTime;
	ldw	x, #(_lastTime + 0)
;	../time.c: 176: }
	addw	sp, #16
	retf
;	../time.c: 179: time_t mktime(struct tm *timeptr) {
;	-----------------------------------------
;	 function mktime
;	-----------------------------------------
_mktime:
	sub	sp, #18
;	../time.c: 180: int year=timeptr->tm_year+1900, month=timeptr->tm_mon, i;
	ldw	y, (0x16, sp)
	ldw	(0x01, sp), y
	ldw	x, y
	ldw	x, (0x5, x)
	addw	x, #0x076c
	ldw	(0x0b, sp), x
	ldw	x, (0x01, sp)
	ld	a, (0x4, x)
	clrw	x
	ld	xl, a
	ldw	(0x03, sp), x
;	../time.c: 183: CheckTime(timeptr);
	ldw	x, (0x01, sp)
	pushw	x
	callf	_CheckTime
	addw	sp, #2
;	../time.c: 186: seconds= (year-1970)*(60*60*24L*365);
	ldw	x, (0x0b, sp)
	subw	x, #0x07b2
	clrw	y
	tnzw	x
	jrpl	00154$
	decw	y
00154$:
	pushw	x
	pushw	y
	push	#0x80
	push	#0x33
	push	#0xe1
	push	#0x01
	callf	__mullong
	addw	sp, #8
;	../time.c: 189: for (i=1970; i<year; i++) {
	ldw	(0x11, sp), x
	ldw	(0x0f, sp), y
	ldw	x, #0x07b2
	ldw	(0x0d, sp), x
00110$:
	ldw	x, (0x0d, sp)
	cpw	x, (0x0b, sp)
	jrsge	00124$
;	../time.c: 190: if (LEAP_YEAR(i)) {
	push	#0x04
	push	#0x00
	ldw	x, (0x0f, sp)
	pushw	x
	callf	__modsint
	addw	sp, #4
	tnzw	x
	jrne	00111$
;	../time.c: 191: seconds+= 60*60*24L;
	ldw	x, (0x11, sp)
	addw	x, #0x5180
	ldw	(0x11, sp), x
	ld	a, (0x10, sp)
	adc	a, #0x01
	ld	(0x10, sp), a
	ld	a, (0x0f, sp)
	adc	a, #0x00
	ld	(0x0f, sp), a
00111$:
;	../time.c: 189: for (i=1970; i<year; i++) {
	ldw	x, (0x0d, sp)
	incw	x
	ldw	(0x0d, sp), x
	jra	00110$
00124$:
	ldw	y, (0x11, sp)
	ldw	(0x07, sp), y
	ldw	y, (0x0f, sp)
	ldw	(0x05, sp), y
;	../time.c: 196: for (i=0; i<month; i++) {
	push	#0x04
	push	#0x00
	ldw	x, (0x0d, sp)
	pushw	x
	callf	__modsint
	addw	sp, #4
	ldw	(0x09, sp), x
	clrw	y
00113$:
	exgw	x, y
	cpw	x, (0x03, sp)
	exgw	x, y
	jrsge	00108$
;	../time.c: 197: if (i==1 && LEAP_YEAR(year)) { 
	cpw	y, #0x0001
	jrne	00105$
	ldw	x, (0x09, sp)
	jrne	00105$
;	../time.c: 198: seconds+= 60*60*24L*29;
	ldw	x, (0x07, sp)
	addw	x, #0x3b80
	ldw	(0x11, sp), x
	ldw	x, (0x05, sp)
	jrnc	00163$
	incw	x
00163$:
	addw	x, #0x0026
	ldw	(0x05, sp), x
	ldw	x, (0x11, sp)
	ldw	(0x07, sp), x
	jra	00114$
00105$:
;	../time.c: 200: seconds+= 60*60*24L*monthDays[i];
	ldw	x, y
	addw	x, #(_monthDays + 0)
	clr	a
	adc	a, #((_monthDays + 0) >> 16)
	ld	a, (x)
	ld	xl, a
	ld	(0x12, sp), a
	exg	a, xl
	clr	(0x11, sp)
	clr	(0x10, sp)
	clr	(0x0f, sp)
	pushw	y
	ldw	x, (0x13, sp)
	pushw	x
	ldw	x, (0x13, sp)
	pushw	x
	push	#0x80
	push	#0x51
	push	#0x01
	push	#0x00
	callf	__mullong
	addw	sp, #8
	ldw	(0x0f, sp), x
	ldw	(0x0d, sp), y
	popw	y
	ldw	x, (0x07, sp)
	addw	x, (0x0d, sp)
	ldw	(0x11, sp), x
	ldw	x, (0x05, sp)
	jrnc	00164$
	incw	x
00164$:
	addw	x, (0x0b, sp)
	ldw	(0x05, sp), x
	ldw	x, (0x11, sp)
	ldw	(0x07, sp), x
00114$:
;	../time.c: 196: for (i=0; i<month; i++) {
	incw	y
	jra	00113$
00108$:
;	../time.c: 204: seconds+= (timeptr->tm_mday-1)*60*60*24L;
	ldw	x, (0x01, sp)
	ld	a, (0x3, x)
	clrw	x
	ld	xl, a
	decw	x
	clrw	y
	tnzw	x
	jrpl	00165$
	decw	y
00165$:
	pushw	x
	pushw	y
	push	#0x80
	push	#0x51
	push	#0x01
	push	#0x00
	callf	__mullong
	addw	sp, #8
	exgw	x, y
	addw	y, (0x07, sp)
	ld	a, xl
	adc	a, (0x06, sp)
	rlwa	x
	adc	a, (0x05, sp)
	ld	xh, a
	ldw	(0x11, sp), y
	ldw	(0x0f, sp), x
;	../time.c: 205: seconds+= timeptr->tm_hour*60*60L;
	ldw	x, (0x01, sp)
	ld	a, (0x2, x)
	clrw	x
	ld	xl, a
	clrw	y
	pushw	x
	pushw	y
	push	#0x10
	push	#0x0e
	clrw	x
	pushw	x
	callf	__mullong
	addw	sp, #8
	ld	a, yl
	addw	x, (0x11, sp)
	adc	a, (0x10, sp)
	rlwa	y
	adc	a, (0x0f, sp)
	ld	yh, a
	ldw	(0x0d, sp), x
;	../time.c: 206: seconds+= timeptr->tm_min*60;
	ldw	x, (0x01, sp)
	ld	a, (0x1, x)
	clrw	x
	ld	xl, a
	pushw	x
	sllw	x
	sllw	x
	sllw	x
	sllw	x
	subw	x, (1, sp)
	sllw	x
	sllw	x
	addw	sp, #2
	ldw	(0x11, sp), x
	ld	a, (0x11, sp)
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	(0x10, sp), a
	ld	(0x0f, sp), a
	ldw	x, (0x0d, sp)
	addw	x, (0x11, sp)
	ld	a, yl
	adc	a, (0x10, sp)
	push	a
	ld	a, yh
	adc	a, (0x10, sp)
	ld	yh, a
	pop	a
	ldw	(0x11, sp), x
	ld	(0x10, sp), a
;	../time.c: 207: seconds+= timeptr->tm_sec;
	ldw	x, (0x01, sp)
	ld	a, (x)
	clrw	x
	ld	xl, a
	ldw	(0x0d, sp), x
	ld	a, (0x0d, sp)
	rlc	a
	clr	a
	sbc	a, #0x00
	ld	(0x0c, sp), a
	ld	(0x0b, sp), a
	ldw	x, (0x11, sp)
	addw	x, (0x0d, sp)
	ld	a, (0x10, sp)
	adc	a, (0x0c, sp)
	rlwa	y
	adc	a, (0x0b, sp)
	ld	yh, a
;	../time.c: 208: return seconds;
;	../time.c: 209: }
	addw	sp, #18
	retf
	.area CODE
	.area CONST
_monthDays:
	.db #0x1f	; 31
	.db #0x1c	; 28
	.db #0x1f	; 31
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x1e	; 30
	.db #0x1f	; 31
	.db #0x1e	; 30
	.db #0x1f	; 31
___month:
	.dw __str_1
	.dw __str_2
	.dw __str_3
	.dw __str_4
	.dw __str_5
	.dw __str_6
	.dw __str_7
	.dw __str_8
	.dw __str_9
	.dw __str_10
	.dw __str_11
	.dw __str_12
___day:
	.dw __str_13
	.dw __str_14
	.dw __str_15
	.dw __str_16
	.dw __str_17
	.dw __str_18
	.dw __str_19
	.area CONST
___str_0:
	.ascii "%s %s %2d %02d:%02d:%02d %04d"
	.db 0x0a
	.db 0x00
	.area CODE
	.area CONST
__str_1:
	.ascii "Jan"
	.db 0x00
	.area CODE
	.area CONST
__str_2:
	.ascii "Feb"
	.db 0x00
	.area CODE
	.area CONST
__str_3:
	.ascii "Mar"
	.db 0x00
	.area CODE
	.area CONST
__str_4:
	.ascii "Apr"
	.db 0x00
	.area CODE
	.area CONST
__str_5:
	.ascii "May"
	.db 0x00
	.area CODE
	.area CONST
__str_6:
	.ascii "Jun"
	.db 0x00
	.area CODE
	.area CONST
__str_7:
	.ascii "Jul"
	.db 0x00
	.area CODE
	.area CONST
__str_8:
	.ascii "Aug"
	.db 0x00
	.area CODE
	.area CONST
__str_9:
	.ascii "Sep"
	.db 0x00
	.area CODE
	.area CONST
__str_10:
	.ascii "Oct"
	.db 0x00
	.area CODE
	.area CONST
__str_11:
	.ascii "Nov"
	.db 0x00
	.area CODE
	.area CONST
__str_12:
	.ascii "Dec"
	.db 0x00
	.area CODE
	.area CONST
__str_13:
	.ascii "Sun"
	.db 0x00
	.area CODE
	.area CONST
__str_14:
	.ascii "Mon"
	.db 0x00
	.area CODE
	.area CONST
__str_15:
	.ascii "Tue"
	.db 0x00
	.area CODE
	.area CONST
__str_16:
	.ascii "Wed"
	.db 0x00
	.area CODE
	.area CONST
__str_17:
	.ascii "Thu"
	.db 0x00
	.area CODE
	.area CONST
__str_18:
	.ascii "Fri"
	.db 0x00
	.area CODE
	.area CONST
__str_19:
	.ascii "Sat"
	.db 0x00
	.area CODE
	.area INITIALIZER
	.area CABS (ABS)
