#
# uCsim avr.src/Makefile
#
# (c) Drotos Daniel, Talker Bt. 1997
#

STARTYEAR	= 1997

SHELL		= /bin/sh
CXX		= g++
CPP		= gcc -E
CXXCPP		= g++ -E
RANLIB		= ranlib
INSTALL		= /usr/bin/install -c
STRIP		= strip
MAKEDEP         = g++ -MM

top_builddir	= ..
top_srcdir	= ..

transform	= s,x,x,

DEFS            = $(subs -DHAVE_CONFIG_H,,-DHAVE_CONFIG_H)
CPPFLAGS        =  -I$(srcdir) -I$(top_srcdir) -I$(top_builddir) \
		  -I$(top_srcdir)/cmd.src -I$(top_srcdir)/sim.src \
		  -I$(top_srcdir)/gui.src
CFLAGS          = -g -O2 -Wall
CXXFLAGS        = -g -O2 -g -Wall
LDFLAGS         = 
PICOPT		=  -fPIC -DPIC
SHAREDLIB	= yes
EXEEXT		= 

LIBS		= -L$(top_builddir) -lsim -lucsimutil -lguiucsim -lcmd -lsim -lrt -lnsl 
DL		= -ldl
dl_ok		= yes

prefix          = /usr/local
exec_prefix     = ${prefix}
bindir          = ${exec_prefix}/bin
libdir          = ${exec_prefix}/lib
datadir         = ${datarootdir}
datarootdir     = ${prefix}/share
includedir      = ${prefix}/include
mandir          = ${datarootdir}/man
man1dir         = $(mandir)/man1
man2dir         = $(mandir)/man2
infodir         = ${datarootdir}/info
srcdir          = .


OBJECTS_SHARED	= glob.o \
		  simavr.o avr.o port.o \
		  inst.o bit_inst.o jump_inst.o move_inst.o logic_inst.o \
		  arith_inst.o
OBJECTS_EXE	= savr.o
OBJECTS		= $(OBJECTS_SHARED) $(OBJECTS_EXE)

enable_dlso	= no
dlso_ok		= no

AVRASM		= tavrasm
TEST_OBJ	= test_bit.hex test_dis.hex test_mov.hex test_jmp.hex \
		  test_arith.hex test_call.hex


# Compiling entire program or any subproject
# ------------------------------------------
all: checkconf otherlibs avr.src


# Compiling and installing everything and runing test
# ---------------------------------------------------
install: all installdirs
	$(INSTALL) savr$(EXEEXT) $(DESTDIR)$(bindir)/`echo savr|sed '$(transform)'`$(EXEEXT)
	$(STRIP) $(DESTDIR)$(bindir)/`echo savr|sed '$(transform)'`$(EXEEXT)


# Deleting all the installed files
# --------------------------------
uninstall:
	rm -f $(DESTDIR)$(bindir)/savr
	rm -f $(DESTDIR)$(bindir)/`echo savr|sed '$(transform)'`$(EXEEXT)


# Performing self-test
# --------------------
check: $(TEST_OBJ)

test:


# Performing installation test
# ----------------------------
installcheck:


# Creating installation directories
# ---------------------------------
installdirs:
	test -d $(DESTDIR)$(bindir) || $(INSTALL) -d $(DESTDIR)$(bindir)


# Creating dependencies
# ---------------------
dep: Makefile.dep

Makefile.dep: $(srcdir)/*.cc $(srcdir)/*.h
	$(MAKEDEP) $(CPPFLAGS) $(filter %.cc,$^) >Makefile.dep

-include Makefile.dep
include $(srcdir)/clean.mk

# My rules
# --------
.SUFFIXES: .asm .hex

avr.src: savr$(EXEEXT) shared_lib

savr$(EXEEXT): $(OBJECTS) $(top_builddir)/libcmd.a $(top_builddir)/libguiucsim.a $(top_builddir)/libsim.a $(top_builddir)/libucsimutil.a
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $(OBJECTS) $(LIBS) -o $@

ifeq ($(dlso_ok),yes)
shared_lib: $(top_builddir)/savr.so
else
shared_lib:
	@$(top_srcdir)/mkecho $(top_builddir) "No AVR shared lib made."
	@$(top_srcdir)/mkecho $(top_builddir) "(SHAREDLIB="$(SHAREDLIB)",dl_ok="$(dl_ok)",enable_dlso="$(enable_dlso)")"
endif

$(top_builddir)/savr.so: $(OBJECTS_SHARED)
	$(CXX) -shared $(LDFLAGS) $(OBJECTS_SHARED) -o $@

otherlibs: $(top_builddir)/libcmd.a $(top_builddir)/libguiucsim.a $(top_builddir)/libsim.a $(top_builddir)/libucsimutil.a

$(top_builddir)/libcmd.a:
	$(MAKE) -C $(top_builddir)/cmd.src all

$(top_builddir)/libguiucsim.a:
	$(MAKE) -C $(top_builddir)/gui.src checkconf ucsim_lib

$(top_builddir)/libsim.a:
	$(MAKE) -C $(top_builddir)/sim.src all

$(top_builddir)/libucsimutil.a:
	$(MAKE) -C $(top_builddir) -f main.mk

.cc.o:
	$(CXX) $(CXXFLAGS) $(PICOPT) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@

.asm.hex:
	$(AVRASM) -l $< -o $@ -e $<.lst


# Remaking configuration
# ----------------------
checkconf:
	@if [ -f $(top_builddir)/devel ]; then\
	  $(MAKE) -C $(top_builddir) -f conf.mk srcdir="$(srcdir)" top_builddir="$(top_builddir)" freshconf;\
	fi

# End of avr.src/Makefile.in
