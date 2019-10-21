#
#
#

VERSION         = 0.0.0
VERSIONHI       = 0
VERSIONLO       = 0
VERSIONP        = 0

SHELL           = /bin/sh
CPP             = gcc -E
INSTALL         = /usr/bin/install -c
CP              = cp

top_builddir    = ../../..
top_srcdir      = ../../..

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

non_free_include_dir_suffix = sdcc/non-free/include
non_free_inclib_dir_suffix = sdcc/non-free

sdcc_includedir    = $(DESTDIR)$(datadir)/$(non_free_include_dir_suffix)

CPPFLAGS        =  -I$(top_builddir)


# Compiling entire program or any subproject
# ------------------------------------------
all:

# Compiling and installing everything and running test
# ----------------------------------------------------
install: all installdirs
	if [ "`grep pic14 $(top_builddir)/ports.build`" = pic14 ]; then \
	  $(CP) $(srcdir)/pic14/*.h $(sdcc_includedir)/pic14; \
	fi
	if [ "`grep pic16 $(top_builddir)/ports.build`" = pic16 ]; then \
	  $(CP) $(srcdir)/pic16/*.h $(sdcc_includedir)/pic16; \
	fi
	rm -rf `find $(sdcc_includedir) -type d -name '.svn'`
	# some files in CVS are executable :-(
	find $(sdcc_includedir) -type f -exec chmod 644 {} \;


# Deleting all the installed files
# --------------------------------
uninstall:
	rm -rf $(sdcc_includedir)
	rm -rf $(DESTDIR)$(datadir)/$(non_free_inclib_dir_suffix)


# Performing self-test
# --------------------
check:


# Performing installation test
# ----------------------------
installcheck:


# Creating installation directories
# ---------------------------------
installdirs:
	[ -d $(sdcc_includedir) ] || mkdir -p $(sdcc_includedir)
	[ -d $(sdcc_includedir)/pic14 ] || mkdir -p $(sdcc_includedir)/pic14
	[ -d $(sdcc_includedir)/pic16 ] || mkdir -p $(sdcc_includedir)/pic16


# Creating dependencies
# ---------------------
dep:

include $(srcdir)/clean.mk

# My rules
# --------


# Remaking configuration
# ----------------------
checkconf:
	@if [ -f $(top_builddir)/devel ]; then \
	  $(MAKE) -f $(srcdir)/conf.mk srcdir="$(srcdir)" top_builddir="$(top_builddir)" \
	  freshconf; \
	fi

# End of main_in.mk/main.mk
