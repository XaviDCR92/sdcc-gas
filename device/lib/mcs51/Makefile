# libc/mcs51 Makefile


srcdir = .

top_srcdir   = ../../..
top_builddir = ../../..

LIB_TYPE     = RANLIB
SAS = $(top_builddir)/bin/sdas8051
SCC = $(top_builddir)/bin/sdcc

# override PORTDIR defined by super (parent) makefile
override PORTDIR = ../build/$(PORT)

OBJ = crtstart.rel crtxinit.rel crtxclear.rel crtclear.rel \
      crtpagesfr.rel crtbank.rel crtcall.rel \
      crtxstack.rel crtxpush.rel crtxpushr0.rel crtxpop.rel crtxpopr0.rel \
      gptr_cmp.rel

LIB = mcs51.lib

CC = $(SCC)
AS = $(SAS)
ASFLAGS = -plosgff

CFLAGS = -I$(top_srcdir)/include --std-c11

all: $(PORTDIR)/$(LIB)

$(PORTDIR)/$(LIB): $(OBJ) Makefile
ifeq ($(LIB_TYPE), SDCCLIB)
	rm -f $@; \
	$(top_builddir)/bin/sdcclib -a $@ $(OBJ)
else
  ifeq ($(LIB_TYPE), AR)
	$(top_builddir)/bin/sdar -rcSD $@ $(OBJ)
  else
    ifeq ($(LIB_TYPE), RANLIB)
	$(top_builddir)/bin/sdar -rcD $@ $(OBJ)
    else
	rm -f $@
	for i in $(basename $(OBJ)); do echo $$i >>$@; done
	cp $(OBJ) $(PORTDIR)
    endif
  endif
endif

%.rel: %.c
	$(CC) $(CFLAGS) -c $<

%.rel: %.asm
	@# TODO: asx8051 should place it\'s output in the current dir
	test $(srcdir) = . || cp $< .
	-$(AS) $(ASFLAGS) $(notdir $<)
	test $(srcdir) = . || rm $(notdir $<)

clean:
	rm -f *.rel *.sym *.lst *~ $(CLEANSPEC) *.dump* *.lib

distclean: clean
	rm -r Makefile
