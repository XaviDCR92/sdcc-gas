#
#
#

SHELL		= /bin/sh
CC		= gcc
CPP		= gcc -E
INSTALL		= /usr/bin/install -c
STRIP           = strip
MAKEDEP         = gcc -MM

top_builddir	= ../../
top_srcdir	= ./../..
SLIB		= $(top_srcdir)/support/util
SDCCLIB		= $(top_srcdir)/src


srcdir		= .

prefix		= /usr/local
exec_prefix     = ${prefix}
bindir          = ${exec_prefix}/bin

transform	= s,x,x,

STD_INC		= @sdcc_include_dir@
CPPFLAGS	=  -I. -I$(top_builddir) -I$(top_srcdir) -I$(SLIB) -DHAVE_CONFIG_H
CFLAGS		=  -pipe -ggdb -g -O2 -Wall
LDFLAGS		= 

EXEEXT          = 

LIBS            = -lnsl  -lreadline
LIBDIRS         =

OBJECTS		= sdcdb.o symtab.o simi.o \
		  break.o cmd.o
SLIBOBJS	= NewAlloc.o
SDCCOBJS	= SDCCset.o SDCChasht.o SDCCerr.o

SOURCES		= $(patsubst %.o,%.c,$(OBJECTS))
SLIBSOURCES	= $(patsubst %.o,$(SLIB)/%.c,$(SLIBOBJS))
SDCCSOURCES	= $(patsubst %.o,$(SDCCLIB)/%.c,$(SDCCOBJS))

TARGET		= $(top_builddir)/bin/sdcdb$(EXEEXT)


# Compiling entire program or any subproject
# ------------------------------------------
all: checkconf $(TARGET)

# Compiling and installing everything and runing test
# ---------------------------------------------------
install: all installdirs
	$(INSTALL) $(TARGET) $(DESTDIR)$(bindir)/`echo sdcdb|sed '$(transform)'`$(EXEEXT)
	$(STRIP) $(DESTDIR)$(bindir)/`echo sdcdb|sed '$(transform)'`$(EXEEXT)
	cp $(srcdir)/sdcdb.el $(DESTDIR)$(bindir)/`echo 'sdcdb'|sed '$(transform)'`.el
	cp $(srcdir)/sdcdbsrc.el $(DESTDIR)$(bindir)/`echo 'sdcdbsrc'|sed '$(transform)'`.el


# Deleting all the installed files
# --------------------------------
uninstall:
	rm -f $(DESTDIR)$(bindir)/`echo sdcdb|sed '$(transform)'`$(EXEEXT)
	rm -f $(DESTDIR)$(bindir)/`echo 'sdcdb'|sed '$(transform)'`.el
	rm -f $(DESTDIR)$(bindir)/`echo 'sdcdbsrc'|sed '$(transform)'`.el

# Performing self-test
# --------------------
check:


# Performing installation test
# ----------------------------
installcheck:


# Creating installation directories
# ---------------------------------
installdirs:
	$(INSTALL) -d $(DESTDIR)$(bindir)


# Creating dependencies
# ---------------------
dep: Makefile.dep

Makefile.dep: $(SOURCES) $(SLIBSOURCES) $(SDCCSOURCES) $(srcdir)/*.h $(top_builddir)/*.h $(top_srcdir)/*.h
	$(MAKEDEP) $(CPPFLAGS) $(filter %.c,$^) >Makefile.dep

ifeq "$(findstring $(MAKECMDGOALS),uninstall installcheck installdirs checkconf \
                                   clean distclean mostlyclean realclean)" ""
  -include Makefile.dep
endif
include $(srcdir)/clean.mk

# My rules
# --------
$(TARGET): $(OBJECTS) $(SLIBOBJS) $(SDCCOBJS)
	$(CC) $(LDFLAGS) -o $@ $(OBJECTS) $(SLIBOBJS) $(SDCCOBJS) $(LIBDIRS) $(LIBS)

.c.o:
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

$(SLIBOBJS):%.o:$(SLIB)/%.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

$(SDCCOBJS):%.o:$(SDCCLIB)/%.c
	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<

# Remaking configuration
# ----------------------
checkconf:
	@if [ -f $(top_builddir)/devel ]; then\
          $(MAKE) -f conf.mk srcdir="$(srcdir)" top_builddir="$(top_builddir)" freshconf;\
        fi

# End of cpp/Makefile
