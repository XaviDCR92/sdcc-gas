#
# uCsim doc/Makefile
#
# (c) Drotos Daniel, Talker Bt. 1997
#

STARTYEAR	= 1997

SHELL		= /bin/sh
INSTALL		= /usr/bin/install -c

top_builddir	= ..
top_srcdir	= ..

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

#docdir		= $(prefix)/share/doc/ucsim
docdir		= ${datarootdir}/doc/${PACKAGE}/ucsim


# Compiling entire program or any subproject
# ------------------------------------------
all: doc

doc: checkconf

# Compiling and installing everything and runing test
# ---------------------------------------------------
install: all installdirs
	cp $(srcdir)/*.html $(DESTDIR)$(docdir)
	cp $(srcdir)/*.svg $(DESTDIR)$(docdir)
	cp $(srcdir)/*.jpg $(DESTDIR)$(docdir)
	cp $(srcdir)/*.fig $(DESTDIR)$(docdir)


# Deleting all the installed files
# --------------------------------
uninstall:
	rm -rf $(DESTDIR)$(docdir)


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
	test -d $(DESTDIR)$(docdir) || $(INSTALL) -d $(DESTDIR)$(docdir)
	test -d $(DESTDIR)$(man1dir) || $(INSTALL) -d $(DESTDIR)$(man1dir)


# Creating dependencies
# ---------------------
include $(srcdir)/clean.mk

# My rules
# --------

# Remaking configuration
# ----------------------
checkconf:
	@if [ -f $(top_builddir)/devel ]; then\
	  $(MAKE) -C $(top_builddir) -f conf.mk srcdir="$(srcdir)" top_builddir="$(top_builddir)" freshconf;\
	fi

# End of s51.src/Makefile.in
