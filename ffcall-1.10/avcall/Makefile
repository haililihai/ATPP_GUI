# Makefile for avcall

#### Start of system configuration section. ####

HOST = x86_64-unknown-linux-gnu
CPU = x86_64
OS = linux-gnu

# Directories used by "make":
srcdir = .

# Directories used by "make install":
prefix = /usr/local
local_prefix = /usr/local
exec_prefix = ${prefix}
libdir = ${exec_prefix}/lib
includedir = ${prefix}/include
mandir = ${prefix}/man
datadir = ${prefix}/share
htmldir = $(datadir)/html

# Programs used by "make":
CC = gcc
CFLAGS = -g -O2
CPP = gcc -E
INCLUDES = -I. -I$(srcdir)
ASPFLAGS = `if test false = true; then echo '-DASM_UNDERSCORE'; fi`
LIBTOOL = $(SHELL) $(top_builddir)/libtool
LIBTOOL_COMPILE = $(LIBTOOL) --mode=compile
LIBTOOL_LINK = $(LIBTOOL) --mode=link
LIBTOOL_INSTALL = $(LIBTOOL) --mode=install
LIBTOOL_UNINSTALL = $(LIBTOOL) --mode=uninstall
AR = ar
AR_FLAGS = rc
RANLIB = ranlib
MV = mv
LN = cp -p
RM = rm -f


# Programs used by "make install":
INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = $(INSTALL)
INSTALL_DATA = $(INSTALL) -m 644

#### End of system configuration section. ####

SHELL = /bin/sh

# Needed by $(LIBTOOL).
top_builddir = .

OBJECTS = avcall.lo structcpy.lo

all : $(OBJECTS) libavcall.la avcall.h $(srcdir)/avcall.3 $(srcdir)/avcall.html

avcall.lo : avcall-$(CPU).lo
	$(RM) avcall.lo avcall.o
	$(LN) avcall-$(CPU).lo avcall.lo
	if test -f avcall-$(CPU).o; then $(LN) avcall-$(CPU).o avcall.o; fi

avcall-i386.lo : avcall-i386.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c avcall-i386.s

avcall-i386.s : $(srcdir)/avcall-i386-macro.S
	$(CPP) $(ASPFLAGS) $(srcdir)/avcall-i386-macro.S | grep -v '^ *#line' | grep -v '^#ident' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,% ,%,g' -e 's,\. ,.,g' > avcall-i386.s

avcall-sparc.lo : avcall-sparc.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c avcall-sparc.s

avcall-sparc.s : $(srcdir)/avcall-sparc.S
	$(CPP) $(ASPFLAGS) $(srcdir)/avcall-sparc.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//.*$$,,' -e 's,\$$,#,g' > avcall-sparc.s

avcall-sparc64.lo : avcall-sparc64.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c avcall-sparc64.s

avcall-sparc64.s : $(srcdir)/avcall-sparc64.S
	$(CPP) $(ASPFLAGS) $(srcdir)/avcall-sparc64.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//.*$$,,' -e 's,\$$,#,g' > avcall-sparc64.s

avcall-m68k.lo : avcall-m68k.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c avcall-m68k.s

avcall-m68k.s : $(srcdir)/avcall-m68k.mit.S $(srcdir)/avcall-m68k.mot.s
	$(CPP) $(ASPFLAGS) $(srcdir)/avcall-m68k.mit.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//.*$$,,' | if test false = true; then sed -e 's/\$$//g'; else sed -e 's/\$$/%/g'; fi > avcall-m68k.s

avcall-mips.lo : avcall-mips.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c avcall-mips.s

avcall-mips.s : $(srcdir)/avcall-mips.S
	$(CPP) $(ASPFLAGS) $(srcdir)/avcall-mips.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//.*$$,,' > avcall-mips.s

avcall-mipsn32.lo : avcall-mipsn32.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c avcall-mipsn32.s

avcall-mipsn32.s : $(srcdir)/avcall-mipsn32.S
	$(CPP) $(ASPFLAGS) $(srcdir)/avcall-mipsn32.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//.*$$,,' > avcall-mipsn32.s

avcall-mips64.lo : avcall-mips64.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c avcall-mips64.s

avcall-mips64.s : $(srcdir)/avcall-mips64.S
	$(CPP) $(ASPFLAGS) $(srcdir)/avcall-mips64.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//.*$$,,' > avcall-mips64.s

avcall-alpha.lo : $(srcdir)/avcall-alpha.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c $(srcdir)/avcall-alpha.s

avcall-hppa.lo : $(srcdir)/avcall-hppa.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c $(srcdir)/avcall-hppa.s

avcall-s390.lo : $(srcdir)/avcall-s390.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c $(srcdir)/avcall-s390.s

avcall-arm.lo : avcall-arm.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c avcall-arm.s

avcall-arm.s : $(srcdir)/avcall-arm.S
	$(CPP) $(ASPFLAGS) $(srcdir)/avcall-arm.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//,@,g' -e 's,\$$,#,g' > avcall-arm.s

avcall-rs6000.lo : $(srcdir)/avcall-rs6000-aix.old.s $(srcdir)/avcall-rs6000-aix.new.s $(srcdir)/avcall-rs6000-sysv4.s $(srcdir)/avcall-rs6000-macos.s
	case "$(OS)" in \
	  aix3*) syntax=aix.old;; \
	  aix*) syntax=aix.new;; \
	  linux* | netbsd*) syntax=linux;; \
	  macos* | darwin*) syntax=macos;; \
	  *) syntax=sysv4;; \
	esac; \
	$(LIBTOOL_COMPILE) $(CC) -x none -c $(srcdir)/avcall-rs6000-$${syntax}.s ; \
	cp avcall-rs6000-$${syntax}.lo avcall-rs6000.lo ; rm -f avcall-rs6000-$${syntax}.lo ; \
	if test -f avcall-rs6000-$${syntax}.o; then mv avcall-rs6000-$${syntax}.o avcall-rs6000.o; fi

avcall-m88k.lo : $(srcdir)/avcall-m88k.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c $(srcdir)/avcall-m88k.s

avcall-convex.lo : $(srcdir)/avcall-convex.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c $(srcdir)/avcall-convex.s

avcall-ia64.lo : $(srcdir)/avcall-ia64.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c $(srcdir)/avcall-ia64.s

avcall-x86_64.lo : $(srcdir)/avcall-x86_64.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c $(srcdir)/avcall-x86_64.s

structcpy.lo : $(srcdir)/structcpy.c
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS) -c $(srcdir)/structcpy.c

libavcall.la : $(OBJECTS)
	$(LIBTOOL_LINK) $(CC) -o libavcall.la -rpath $(libdir) $(OBJECTS)

# Installs the library and include files only. Typically called with only
# $(libdir) and $(includedir) - don't use $(prefix) and $(exec_prefix) here.
install-lib : all force
	if [ ! -d $(libdir) ] ; then mkdir $(libdir) ; fi
	$(LIBTOOL_INSTALL) $(INSTALL_DATA) libavcall.la $(libdir)/libavcall.la
	if [ ! -d $(includedir) ] ; then mkdir $(includedir) ; fi
	$(INSTALL_DATA) avcall.h $(includedir)/avcall.h

install : all force
	if [ ! -d $(DESTDIR)$(prefix) ] ; then mkdir $(DESTDIR)$(prefix) ; fi
	if [ ! -d $(DESTDIR)$(exec_prefix) ] ; then mkdir $(DESTDIR)$(exec_prefix) ; fi
	if [ ! -d $(DESTDIR)$(libdir) ] ; then mkdir $(DESTDIR)$(libdir) ; fi
	$(LIBTOOL_INSTALL) $(INSTALL_DATA) libavcall.la $(DESTDIR)$(libdir)/libavcall.la
	if [ ! -d $(DESTDIR)$(includedir) ] ; then mkdir $(DESTDIR)$(includedir) ; fi
	$(INSTALL_DATA) avcall.h $(DESTDIR)$(includedir)/avcall.h
	if [ ! -d $(DESTDIR)$(mandir) ] ; then mkdir $(DESTDIR)$(mandir) ; fi
	if [ ! -d $(DESTDIR)$(mandir)/man3 ] ; then mkdir $(DESTDIR)$(mandir)/man3 ; fi
	$(INSTALL_DATA) $(srcdir)/avcall.3 $(DESTDIR)$(mandir)/man3/avcall.3
	if [ ! -d $(DESTDIR)$(datadir) ] ; then mkdir $(DESTDIR)$(datadir) ; fi
	if [ ! -d $(DESTDIR)$(htmldir) ] ; then mkdir $(DESTDIR)$(htmldir) ; fi
	$(INSTALL_DATA) $(srcdir)/avcall.html $(DESTDIR)$(htmldir)/avcall.html

installdirs : force
	if [ ! -d $(DESTDIR)$(prefix) ] ; then mkdir $(DESTDIR)$(prefix) ; fi
	if [ ! -d $(DESTDIR)$(exec_prefix) ] ; then mkdir $(DESTDIR)$(exec_prefix) ; fi
	if [ ! -d $(DESTDIR)$(libdir) ] ; then mkdir $(DESTDIR)$(libdir) ; fi
	if [ ! -d $(DESTDIR)$(includedir) ] ; then mkdir $(DESTDIR)$(includedir) ; fi
	if [ ! -d $(DESTDIR)$(mandir) ] ; then mkdir $(DESTDIR)$(mandir) ; fi
	if [ ! -d $(DESTDIR)$(mandir)/man3 ] ; then mkdir $(DESTDIR)$(mandir)/man3 ; fi
	if [ ! -d $(DESTDIR)$(datadir) ] ; then mkdir $(DESTDIR)$(datadir) ; fi
	if [ ! -d $(DESTDIR)$(htmldir) ] ; then mkdir $(DESTDIR)$(htmldir) ; fi

uninstall : force
	$(LIBTOOL_UNINSTALL) $(RM) $(DESTDIR)$(libdir)/libavcall.la
	$(RM) $(DESTDIR)$(includedir)/avcall.h
	$(RM) $(DESTDIR)$(mandir)/man3/avcall.3
	$(RM) $(DESTDIR)$(htmldir)/avcall.html

minitests.o : $(srcdir)/minitests.c $(srcdir)/tests.c avcall.h
	$(CC) $(CFLAGS) $(INCLUDES) -c $(srcdir)/minitests.c

minitests.s : $(srcdir)/minitests.c $(srcdir)/tests.c avcall.h
	$(CC) $(CFLAGS) $(INCLUDES) -S $(srcdir)/minitests.c

minitests : minitests.o libavcall.la
	$(LIBTOOL_LINK) $(CC) $(CFLAGS) -x none minitests.o libavcall.la -o minitests

check : all minitests
	./minitests > minitests.out
	LC_ALL=C uniq -u < minitests.out > minitests.output.$(HOST)
	test '!' -s minitests.output.$(HOST)

tests.o : $(srcdir)/tests.c avcall.h
	$(CC) $(CFLAGS) $(INCLUDES) -c $(srcdir)/tests.c

tests.s : $(srcdir)/tests.c avcall.h
	$(CC) $(CFLAGS) $(INCLUDES) -S $(srcdir)/tests.c

tests : tests.o libavcall.la
	$(LIBTOOL_LINK) $(CC) $(CFLAGS) -x none tests.o libavcall.la -o tests

extracheck : all tests
	./tests > tests.out
	LC_ALL=C uniq -u < tests.out > tests.output.$(HOST)
	test '!' -s tests.output.$(HOST)

mostlyclean : clean

clean : force
	$(RM) *.o *.lo *.a libavcall.* core
	$(RM) avcall-i386.s avcall-sparc.s avcall-sparc64.s avcall-m68k.s avcall-mips.s avcall-mipsn32.s avcall-mips64.s avcall-arm.s
	$(RM) -r .libs _libs
	$(RM) minitests.o minitests.s minitests minitests.out
	$(RM) tests.o tests.s tests tests.out

distclean : clean
	$(RM) config.status config.log config.cache Makefile avcall.h libtool minitests.output.* tests.output.*

maintainer-clean : distclean

force :

