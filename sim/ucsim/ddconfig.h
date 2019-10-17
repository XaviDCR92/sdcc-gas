/* ddconfig.h.  Generated from ddconfig_in.h by configure.  */
/* ddconfig_in.h.  Generated from configure.ac by autoheader.  */

#ifndef DDCONFIG_HEADER
#define DDCONFIG_HEADER

/* Define to be the type of length parameter of accept (without the \*'). */
#define ACCEPT_SOCKLEN_T socklen_t

/* Define if building universal (internal helper macro) */
/* #undef AC_APPLE_UNIVERSAL_BUILD */

/* XXX */
#define FD_HEADER_OK 1

/* XXX */
#define FD_NEED_SELECT_H 1

/* XXX */
#define FD_NEED_TIME_H 0

/* XXX */
#define FD_NEED_TYPES_H 0

/* XXX */
#define FD_NEED_WINSOCK2_H 0

/* XXX */
/* #undef GNU_GETCWD */

/* XXX */
#define HAVE_CURSES_H 1

/* Define to 1 if you have the <dirent.h> header file, and it defines `DIR'.
   */
#define HAVE_DIRENT_H 1

/* Define to 1 if you have the <dlfcn.h> header file. */
#define HAVE_DLFCN_H 1

/* Define to 1 if you have the <endian.h> header file. */
#define HAVE_ENDIAN_H 1

/* XXX */
#define HAVE_FLEX 1

/* Define to 1 if you have the <getopt.h> header file. */
#define HAVE_GETOPT_H 1

/* Define to 1 if you have the <inttypes.h> header file. */
#define HAVE_INTTYPES_H 1

/* Define to 1 if you have the `nsl' library (-lnsl). */
#define HAVE_LIBNSL 1

/* Define to 1 if you have the `rt' library (-lrt). */
#define HAVE_LIBRT 1

/* Define to 1 if you have the `socket' library (-lsocket). */
/* #undef HAVE_LIBSOCKET */

/* Define to 1 if you have the <machine/endian.h> header file. */
/* #undef HAVE_MACHINE_ENDIAN_H */

/* Define to 1 if you have the <memory.h> header file. */
#define HAVE_MEMORY_H 1

/* Define to 1 if you have the <ndir.h> header file, and it defines `DIR'. */
/* #undef HAVE_NDIR_H */

/* Define to 1 if you have the <stdint.h> header file. */
#define HAVE_STDINT_H 1

/* Define to 1 if you have the <stdlib.h> header file. */
#define HAVE_STDLIB_H 1

/* Define to 1 if you have the `strdup' function. */
#define HAVE_STRDUP 1

/* Define to 1 if you have the `strerror' function. */
#define HAVE_STRERROR 1

/* Define to 1 if you have the <strings.h> header file. */
#define HAVE_STRINGS_H 1

/* Define to 1 if you have the <string.h> header file. */
#define HAVE_STRING_H 1

/* Define to 1 if you have the <sys/dir.h> header file, and it defines `DIR'.
   */
/* #undef HAVE_SYS_DIR_H */

/* Define to 1 if you have the <sys/endian.h> header file. */
/* #undef HAVE_SYS_ENDIAN_H */

/* Define to 1 if you have the <sys/isa_defs.h> header file. */
/* #undef HAVE_SYS_ISA_DEFS_H */

/* Define to 1 if you have the <sys/ndir.h> header file, and it defines `DIR'.
   */
/* #undef HAVE_SYS_NDIR_H */

/* XXX */
#define HAVE_SYS_SOCKET_H 1

/* Define to 1 if you have the <sys/stat.h> header file. */
#define HAVE_SYS_STAT_H 1

/* Define to 1 if you have the <sys/types.h> header file. */
#define HAVE_SYS_TYPES_H 1

/* Define to 1 if you have the <termios.h> header file. */
#define HAVE_TERMIOS_H 1

/* Define to 1 if you have the <unistd.h> header file. */
#define HAVE_UNISTD_H 1

/* Define to 1 if you have the `vasprintf' function. */
#define HAVE_VASPRINTF 1

/* XXX */
/* #undef HAVE_WINSOCK2_H */

/* Define to 1 if you have the `yylex' function. */
/* #undef HAVE_YYLEX */

/* XXX */
#define HEADER_FD <sys/select.h>

/* XXX */
#define HEADER_SOCKET <sys/socket.h>

/* Define to the sub-directory where libtool stores uninstalled libraries. */
#define LT_OBJDIR ".libs/"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT ""

/* Define to the full name of this package. */
#define PACKAGE_NAME ""

/* Define to the full name and version of this package. */
#define PACKAGE_STRING ""

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME ""

/* Define to the home page for this package. */
#define PACKAGE_URL ""

/* Define to the version of this package. */
#define PACKAGE_VERSION ""

/* Define as the return type of signal handlers (`int' or `void'). */
#define RETSIGTYPE void

/* XXX */
/* #undef SCANF_A */

/* The size of `char', as computed by sizeof. */
#define SIZEOF_CHAR 1

/* The size of `int', as computed by sizeof. */
#define SIZEOF_INT 4

/* The size of `long', as computed by sizeof. */
#define SIZEOF_LONG 8

/* The size of `long long', as computed by sizeof. */
#define SIZEOF_LONG_LONG 8

/* The size of `short', as computed by sizeof. */
#define SIZEOF_SHORT 2

/* XXX */
#define SOCKET_AVAIL 1

/* XXX */
#define SOCKLEN_T uint

/* XXX */
#define STATISTIC no

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* XXX */
#define TYPE_BYTE char
#define SPEC_BYTE ""

/* XXX */
#define TYPE_DWORD int
#define SPEC_DWORD ""

/* XXX */
#define TYPE_QWORD long
#define SPEC_QWORD "l"

/* XXX */
#define TYPE_WORD short
#define SPEC_WORD "h"

/* XXX */
#define UCSOCKET_T int

/* XXX */
#define VERSIONHI 0

/* XXX */
#define VERSIONLO 6-pre56

/* XXX */
#define VERSIONP 

/* XXX */
#define VERSIONSTR "0.6-pre56"

/* Define WORDS_BIGENDIAN to 1 if your processor stores words with the most
   significant byte first (like Motorola and SPARC, unlike Intel). */
#if defined AC_APPLE_UNIVERSAL_BUILD
# if defined __BIG_ENDIAN__
#  define WORDS_BIGENDIAN 1
# endif
#else
# ifndef WORDS_BIGENDIAN
/* #  undef WORDS_BIGENDIAN */
# endif
#endif

/* Define to 1 if `lex' declares `yytext' as a `char *' by default, not a
   `char[]'. */
#define YYTEXT_POINTER 1

/* XXX */
#define _A_ ""

/* XXX */
#define _M_ "h"

/* ucsim custom defines */
#define DD_TRUE     1
#define DD_FALSE    0
#define NIL         0
#endif /* DDCONFIG_HEADER */
