#
# uCsim xa.src/Makefile
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
MAKEDEP		= g++ -MM

top_builddir	= ..
top_srcdir	= ..

transform	= s,x,x,

EXEEXT		= 

DEFS            = $(subs -DHAVE_CONFIG_H,,-DHAVE_CONFIG_H)
CPPFLAGS        =  -I$(srcdir) -I$(top_srcdir) -I$(top_builddir) \
		  -I$(top_srcdir)/cmd.src -I$(top_srcdir)/sim.src \
		  -I$(top_srcdir)/gui.src
CFLAGS          = -g -O2 -Wall
CXXFLAGS        = -g -O2 -g -Wall
LDFLAGS         = 
PICOPT		=  -fPIC -DPIC

LIBS		= -L$(top_builddir) -lsim -lucsimutil -lguiucsim -lcmd -lsim -lrt -lnsl 

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


OBJECTS         = sxa.o glob.o \
		  inst.o \
		  simxa.o xa.o

XAASM		= 
#TEST_OBJ	= test_bit.hex test_dis.hex test_mov.hex test_jmp.hex \
#		  test_arith.hex


# Compiling entire program or any subproject
# ------------------------------------------
all: checkconf otherlibs xa.src tests

tests: $(TEST_OBJ)


# Compiling and installing everything and runing test
# ---------------------------------------------------
install: all installdirs
	$(INSTALL) sxa$(EXEEXT) $(DESTDIR)$(bindir)/`echo sxa|sed '$(transform)'`$(EXEEXT)
	$(STRIP) $(DESTDIR)$(bindir)/`echo sxa|sed '$(transform)'`$(EXEEXT)


# Deleting all the installed files
# --------------------------------
uninstall:
	rm -f $(DESTDIR)$(bindir)/`echo sxa|sed '$(transform)'`$(EXEEXT)


# Performing self-test
# --------------------
check:


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

xa.src: sxa$(EXEEXT)

sxa$(EXEEXT): $(OBJECTS) $(top_builddir)/libcmd.a $(top_builddir)/libguiucsim.a $(top_builddir)/libsim.a $(top_builddir)/libucsimutil.a
	$(CXX) $(CXXFLAGS) $(LDFLAGS) $(OBJECTS) $(LIBS) -o $@

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
	$(XAASM) -l $< -o $@ -e $<.lst


# Remaking configuration
# ----------------------
checkconf:
	@if [ -f $(top_builddir)/devel ]; then\
	  $(MAKE) -f $(srcdir)/conf.mk srcdir="$(srcdir)" top_builddir="$(top_builddir)" freshconf;\
	fi

# End of xa.src/Makefile.in
