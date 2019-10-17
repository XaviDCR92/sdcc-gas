# Makefile for kano-networks talker

SHELL		= /bin/sh
CXX		= g++
CXXCPP		= g++ -E
INSTALL		= /usr/bin/install -c
STRIP		= strip
CP		= /bin/cp
MAKEDEP         = g++ -MM

top_builddir	= ../..
top_srcdir	= ../..

DEFS            = $(subs -DHAVE_CONFIG_H,,-DHAVE_CONFIG_H)
CPPFLAGS        =  -I. -I$(top_builddir)
#		  -I$(top_builddir)/cmd.src -I$(top_builddir)/sim.src
CFLAGS          = -g -O2 -Wall
CXXFLAGS        = -g -O2 -g -Wall

LIBS		= -lpanel -lcurses -lrt -lnsl 

EXEEXT		= 

curses_ok	= yes

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


OBJECTS		= main.o fileio.o frontend.o posix_signal.o


# Compiling entire program or any subproject
# ------------------------------------------
all: serio.src

ifeq ($(curses_ok),yes)
serio.src: checkconf serialview$(EXEEXT)
else
serio.src: checkconf
endif


# Compiling and installing everything and runing test
# ---------------------------------------------------
install: all installdirs
	$(INSTALL) serialview$(EXEEXT) $(DESTDIR)$(bindir)/serialview$(EXEEXT)
	$(STRIP) $(DESTDIR)$(bindir)/serialview$(EXEEXT)


# Deleting all the installed files
# --------------------------------
uninstall:
	rm -f $(DESTDIR)$(bindir)/serialview$(EXEEXT)


# Performing self-test
# --------------------
check:

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

Makefile.dep: $(srcdir)/*.cc $(srcdir)/*.h $(srcdir)/*.hh
	$(MAKEDEP) $(CPPFLAGS) $(filter %.cc,$^) >Makefile.dep

ifeq "$(findstring $(MAKECMDGOALS),uninstall installcheck installdirs checkconf \
                                   clean distclean mostlyclean realclean)" ""
  -include Makefile.dep
endif
include $(srcdir)/clean.mk


# My rules
# --------
serialview$(EXEEXT): $(OBJECTS)
	$(CXX) -o $@ $(LDFLAGS) $(OBJECTS) $(LIBS)

.cc.o:
	$(CXX) $(CXXFLAGS)  $(CPPFLAGS) -c $< -o $@

# Remaking configuration
# ----------------------
checkconf:
	@if [ -f $(top_builddir)/devel ]; then\
	  $(MAKE) -f conf.mk srcdir="$(srcdir)" top_builddir="$(top_builddir)" top_srcdir=$(top_srcdir) freshconf;\
	fi

# End of gui.src/serio.src/Makefile.in
