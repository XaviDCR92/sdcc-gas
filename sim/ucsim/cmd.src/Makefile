#
# ucsim cmd.src/Makefile
#
# (c) Drotos Daniel, Talker Bt. 1997
#

STARTYEAR	= 1997

SHELL		= /bin/sh
CXX		= g++
CPP		= gcc -E
CXXCPP		= g++ -E
RANLIB		= ranlib
INSTALL	        = /usr/bin/install -c
MAKEDEP         = g++ -MM
AR		= ar

LEX		= flex
YACC		= bison -y

top_builddir	= ..
top_srcdir	= ..

DEFS            = $(subs -DHAVE_CONFIG_H,,-DHAVE_CONFIG_H)
CPPFLAGS        =  -I$(srcdir) -I$(top_srcdir) -I$(top_builddir) \
		  -I$(top_srcdir)/sim.src -I$(top_srcdir)/gui.src
CFLAGS          = -g -O2 -Wall
CXXFLAGS        = -g -O2 -g -Wall
WINSOCK_AVAIL   = 0

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


OBJECTS         = command.o cmdutil.o syntax.o newcmd.o newcmdposix.o\
		  cmd_exec.o cmd_get.o cmd_set.o cmd_timer.o cmd_bp.o \
		  cmd_info.o cmd_show.o cmd_gui.o \
		  cmd_conf.o cmd_uc.o cmd_stat.o cmd_mem.o

#ifeq ($(WINSOCK_AVAIL), 1)
#OBJECTS += newcmdwin32.o
#else
#OBJECTS += newcmdposix.o
#endif

LOCAL_OBJECTS   = cmdpars.o cmdlex.o

SOURCES         = $(addprefix $(srcdir)/, $(OBJECTS:.o=.cc))
LOCAL_SOURCES   = $(LOCAL_OBJECTS:.o=.cc)

# Compiling entire program or any subproject
# ------------------------------------------
all: checkconf cmdlib

cmd.src: all


# Compiling and installing everything and runing test
# ---------------------------------------------------
install: all installdirs


# Deleting all the installed files
# --------------------------------
uninstall:


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


# Creating dependencies
# ---------------------
dep: $(LOCAL_SOURCES) Makefile.dep

Makefile.dep: $(SOURCES) $(LOCAL_SOURCES) $(srcdir)/*.h cmdpars.hh cmdpars.cc
	$(MAKEDEP) $(CPPFLAGS) $(SOURCES) $(LOCAL_SOURCES) >Makefile.dep

-include Makefile.dep
include $(srcdir)/clean.mk

cmdlex.cc: cmdlex.l cmdpars.hh

# My rules
# --------

cmdlib: $(top_builddir)/libcmd.a

$(top_builddir)/libcmd.a: $(OBJECTS) $(LOCAL_OBJECTS)
	$(AR) -rc $@ $(OBJECTS) $(LOCAL_OBJECTS)
	$(RANLIB) $@

.cc.o:
	$(CXX) $(CXXFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@

cmdpars.hh: cmdpars.cc

cmdpars.cc: cmdpars.y
	$(YACC) -d $<
	mv y.tab.c $*.cc
	mv y.tab.h $*.hh

.l.cc:
	rm -f $@
	$(LEX) -t $< > $@

# Remaking configuration
# ----------------------
checkconf:
	@if [ -f $(top_builddir)/devel ]; then\
	  $(MAKE) -C $(top_builddir) -f conf.mk srcdir="$(srcdir)" top_builddir="$(top_builddir)" freshconf;\
	fi

# End of cmd.src/Makefile.in
