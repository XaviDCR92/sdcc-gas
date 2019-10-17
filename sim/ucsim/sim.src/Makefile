#
# S51 sim.src/Makefile
#
# (c) Drotos Daniel, Talker Bt. 1997,99
#

STARTYEAR	= 1997

SHELL		= /bin/sh
CXX		= g++
CPP		= gcc -E
CXXCPP		= g++ -E
RANLIB		= ranlib
INSTALL		= /usr/bin/install -c
MAKEDEP         = g++ -MM
AR		= ar

top_builddir	= ..
top_srcdir	= ..

DEFS            = $(subs -DHAVE_CONFIG_H,,-DHAVE_CONFIG_H)
CPPFLAGS        =  -I$(srcdir) -I$(top_srcdir) -I$(top_builddir) \
		  -I$(top_srcdir)/cmd.src -I$(top_srcdir)/gui.src
CFLAGS          = -g -O2 -Wall
CXXFLAGS        = -g -O2 -g -Wall

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


OBJECTS         = stack.o mem.o sim.o itsrc.o brk.o arg.o \
		  guiobj.o uc.o hw.o simif.o serial_hw.o port_hw.o \
		  iwrap.o var.o vcd.o


# Compiling entire program or any subproject
# ------------------------------------------
all: checkconf sim_lib

test_mem_speed: $(top_builddir)/lib*.a test_mem_speed.o
	$(CXX) -o $@ test_mem_speed.o -L$(top_builddir) -Wl,--start-group -lsim -lucsimutil -lcmd -Wl,--end-group

sim.src: all


# Compiling and installing everything and runing test
# ---------------------------------------------------
install: all installdirs


# Deleting all the installed files
# --------------------------------
uninstall:


# Performing self-test
# --------------------
check: test
	./test_mem_speed

test: test_mem_speed

# Performing installation test
# ----------------------------
installcheck:


# Creating installation directories
# ---------------------------------
installdirs:


# Creating dependencies
# ---------------------
dep: main.dep

Makefile.dep: $(srcdir)/*.cc $(srcdir)/*.h
	$(MAKEDEP) $(CPPFLAGS) $(filter %.cc,$^) >Makefile.dep

-include Makefile.dep
include $(srcdir)/clean.mk

#parser.cc: parser.y

#plex.cc: plex.l

# My rules
# --------

sim_lib: $(top_builddir)/libsim.a

$(top_builddir)/libsim.a: $(OBJECTS)
	$(AR) -rc $@ $(OBJECTS)
	$(RANLIB) $@

.cc.o:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@

.y.cc:
	rm -f $*.cc $*.h
	$(YACC) -d $<
	mv y.tab.c $*.cc
	mv y.tab.h $*.h

.l.cc:
	rm -f $*.cc
	$(LEX) -t $< >$*.cc


# Remaking configuration
# ----------------------
checkconf:
	@if [ -f $(top_builddir)/devel ]; then\
	  $(MAKE) -f conf.mk srcdir="$(srcdir)" top_builddir="$(top_builddir)" freshconf;\
	fi

# End of sim.src/Makefile
