                                      1 ;--------------------------------------------------------
                                      2 ; File Created by SDCC : free open source ANSI-C Compiler
                                      3 ; Version 3.9.3 #11345 (Linux)
                                      4 ;--------------------------------------------------------
                                      5 	.module main_sdcc
                                      6 	.optsdcc -mstm8
                                      7 	
                                      8 ;--------------------------------------------------------
                                      9 ; Public variables in this module
                                     10 ;--------------------------------------------------------
                                     11 	.globl _main
                                     12 ;--------------------------------------------------------
                                     13 ; ram data
                                     14 ;--------------------------------------------------------
                                     15 	.area DATA
                                     16 ;--------------------------------------------------------
                                     17 ; ram data
                                     18 ;--------------------------------------------------------
                                     19 	.area INITIALIZED
                                     20 ;--------------------------------------------------------
                                     21 ; Stack segment in internal ram 
                                     22 ;--------------------------------------------------------
                                     23 	.area	SSEG
      FFFFFF                         24 __start__stack:
      FFFFFF                         25 	.ds	1
                                     26 
                                     27 ;--------------------------------------------------------
                                     28 ; absolute external ram data
                                     29 ;--------------------------------------------------------
                                     30 	.area DABS (ABS)
                                     31 
                                     32 ; default segment ordering for linker
                                     33 	.area HOME
                                     34 	.area GSINIT
                                     35 	.area GSFINAL
                                     36 	.area CONST
                                     37 	.area INITIALIZER
                                     38 	.area CODE
                                     39 
                                     40 ;--------------------------------------------------------
                                     41 ; interrupt vector 
                                     42 ;--------------------------------------------------------
                                     43 	.area HOME
      008000                         44 __interrupt_vect:
      008000 82 00 80 07             45 	int s_GSINIT ; reset
                                     46 ;--------------------------------------------------------
                                     47 ; global & static initialisations
                                     48 ;--------------------------------------------------------
                                     49 	.area HOME
                                     50 	.area GSINIT
                                     51 	.area GSFINAL
                                     52 	.area GSINIT
      008007                         53 __sdcc_gs_init_startup:
      008007                         54 __sdcc_init_data:
                                     55 ; stm8_genXINIT() start
      008007 AE 00 00         [ 2]   56 	ldw x, #l_DATA
      00800A 27 07            [ 1]   57 	jreq	00002$
      00800C                         58 00001$:
      00800C 72 4F 00 00      [ 1]   59 	clr (s_DATA - 1, x)
      008010 5A               [ 2]   60 	decw x
      008011 26 F9            [ 1]   61 	jrne	00001$
      008013                         62 00002$:
      008013 AE 00 00         [ 2]   63 	ldw	x, #l_INITIALIZER
      008016 27 09            [ 1]   64 	jreq	00004$
      008018                         65 00003$:
      008018 D6 80 23         [ 1]   66 	ld	a, (s_INITIALIZER - 1, x)
      00801B D7 00 00         [ 1]   67 	ld	(s_INITIALIZED - 1, x), a
      00801E 5A               [ 2]   68 	decw	x
      00801F 26 F7            [ 1]   69 	jrne	00003$
      008021                         70 00004$:
                                     71 ; stm8_genXINIT() end
                                     72 	.area GSFINAL
      008021 CC 80 04         [ 2]   73 	jp	__sdcc_program_startup
                                     74 ;--------------------------------------------------------
                                     75 ; Home
                                     76 ;--------------------------------------------------------
                                     77 	.area HOME
                                     78 	.area HOME
      008004                         79 __sdcc_program_startup:
      008004 CC 80 24         [ 2]   80 	jp	_main
                                     81 ;	return from main will return to caller
                                     82 ;--------------------------------------------------------
                                     83 ; code
                                     84 ;--------------------------------------------------------
                                     85 	.area CODE
                                     86 ;	/home/xavier/main_sdcc.c: 1: int main()
                                     87 ;	-----------------------------------------
                                     88 ;	 function main
                                     89 ;	-----------------------------------------
      008024                         90 _main:
                                     91 ;	/home/xavier/main_sdcc.c: 3: return 0;
      008024 5F               [ 1]   92 	clrw	x
                                     93 ;	/home/xavier/main_sdcc.c: 4: }
      008025 81               [ 4]   94 	ret
                                     95 	.area CODE
                                     96 	.area CONST
                                     97 	.area INITIALIZER
                                     98 	.area CABS (ABS)
