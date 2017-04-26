# Makefile for vacall

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

OBJECTS = vacall.o misc.o structcpy.o

all : $(OBJECTS) libvacall.a vacall.h $(srcdir)/vacall.3 $(srcdir)/vacall.html

vacall.o : vacall-$(CPU).o
	$(RM) vacall.o
	$(LN) vacall-$(CPU).o vacall.o

vacall-i386.o : vacall-i386.s
	$(CC) -x none -c vacall-i386.s

vacall-i386.s : $(srcdir)/vacall-i386-macro.S
	$(CPP) $(ASPFLAGS) $(srcdir)/vacall-i386-macro.S | grep -v '^ *#line' | grep -v '^#ident' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,% ,%,g' -e 's,\. ,.,g' > vacall-i386.s

vacall-sparc.o : vacall-sparc.s
	$(CC) -x none -c vacall-sparc.s

vacall-sparc.s : $(srcdir)/vacall-sparc.S
	$(CPP) $(ASPFLAGS) $(srcdir)/vacall-sparc.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//.*$$,,' -e 's,\$$,#,g' > vacall-sparc.s

vacall-sparc64.o : vacall-sparc64.s
	$(CC) -x none -c vacall-sparc64.s

vacall-sparc64.s : $(srcdir)/vacall-sparc64.S
	$(CPP) $(ASPFLAGS) $(srcdir)/vacall-sparc64.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//.*$$,,' -e 's,\$$,#,g' > vacall-sparc64.s

vacall-m68k.o : vacall-m68k.s
	$(CC) -x none -c vacall-m68k.s

vacall-m68k.s : $(srcdir)/vacall-m68k.mit.S $(srcdir)/vacall-m68k.mot.s
	$(CPP) $(ASPFLAGS) $(srcdir)/vacall-m68k.mit.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//.*$$,,' | if test false = true; then sed -e 's/\$$//g'; else sed -e 's/\$$/%/g'; fi > vacall-m68k.s

vacall-mips.o : vacall-mips.s
	$(CC) -x none -c vacall-mips.s

vacall-mips.s : $(srcdir)/vacall-mips.S
	$(CPP) $(ASPFLAGS) $(srcdir)/vacall-mips.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//.*$$,,' > vacall-mips.s

vacall-mipsn32.o : vacall-mipsn32.s
	$(CC) -x none -c vacall-mipsn32.s

vacall-mipsn32.s : $(srcdir)/vacall-mipsn32.S
	$(CPP) $(ASPFLAGS) $(srcdir)/vacall-mipsn32.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//.*$$,,' > vacall-mipsn32.s

vacall-mips64.o : vacall-mips64.s
	$(CC) -x none -c vacall-mips64.s

vacall-mips64.s : $(srcdir)/vacall-mips64.S
	$(CPP) $(ASPFLAGS) $(srcdir)/vacall-mips64.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//.*$$,,' > vacall-mips64.s

vacall-alpha.o : $(srcdir)/vacall-alpha.s
	$(CC) -x none -c $(srcdir)/vacall-alpha.s

vacall-hppa.o : $(srcdir)/vacall-hppa.s
	$(CC) -x none -c $(srcdir)/vacall-hppa.s

vacall-s390.o : $(srcdir)/vacall-s390.s
	$(CC) -x none -c $(srcdir)/vacall-s390.s

vacall-arm.o : vacall-arm.s
	$(CC) -x none -c vacall-arm.s

vacall-arm.s : $(srcdir)/vacall-arm.S
	$(CPP) $(ASPFLAGS) $(srcdir)/vacall-arm.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//,@,g' -e 's,\$$,#,g' > vacall-arm.s

vacall-rs6000.o : $(srcdir)/vacall-rs6000-aix.old.s $(srcdir)/vacall-rs6000-aix.new.s $(srcdir)/vacall-rs6000-sysv4.s $(srcdir)/vacall-rs6000-linux.s $(srcdir)/vacall-rs6000-macos.s
	case "$(OS)" in \
	  aix3*) syntax=aix.old;; \
	  aix*) syntax=aix.new;; \
	  linux* | netbsd*) syntax=linux;; \
	  macos* | darwin*) syntax=macos;; \
	  *) syntax=sysv4;; \
	esac; \
	$(CC) -x none -c $(srcdir)/vacall-rs6000-$${syntax}.s ; \
	mv vacall-rs6000-$${syntax}.o vacall-rs6000.o

vacall-m88k.o : $(srcdir)/vacall-m88k.s
	$(CC) -x none -c $(srcdir)/vacall-m88k.s

vacall-convex.o : $(srcdir)/vacall-convex.s
	$(CC) -x none -c $(srcdir)/vacall-convex.s

vacall-ia64.o : $(srcdir)/vacall-ia64.s
	$(CC) -x none -c $(srcdir)/vacall-ia64.s

vacall-x86_64.o : $(srcdir)/vacall-x86_64.s
	$(CC) -x none -c $(srcdir)/vacall-x86_64.s

misc.o : $(srcdir)/misc.c vacall.h config.h
	$(CC) $(CFLAGS) $(INCLUDES) -c $(srcdir)/misc.c

structcpy.o : $(srcdir)/structcpy.c
	$(CC) $(CFLAGS) -c $(srcdir)/structcpy.c

libvacall.a : $(OBJECTS)
	$(RM) libvacall.a
	$(AR) $(AR_FLAGS) libvacall.a $(OBJECTS)
	$(RANLIB) libvacall.a

install : all force
	if [ ! -d $(DESTDIR)$(prefix) ] ; then mkdir $(DESTDIR)$(prefix) ; fi
	if [ ! -d $(DESTDIR)$(exec_prefix) ] ; then mkdir $(DESTDIR)$(exec_prefix) ; fi
	if [ ! -d $(DESTDIR)$(libdir) ] ; then mkdir $(DESTDIR)$(libdir) ; fi
	$(INSTALL_DATA) libvacall.a $(DESTDIR)$(libdir)/libvacall.a
	if [ ! -d $(DESTDIR)$(includedir) ] ; then mkdir $(DESTDIR)$(includedir) ; fi
	$(INSTALL_DATA) vacall.h $(DESTDIR)$(includedir)/vacall.h
	if [ ! -d $(DESTDIR)$(mandir) ] ; then mkdir $(DESTDIR)$(mandir) ; fi
	if [ ! -d $(DESTDIR)$(mandir)/man3 ] ; then mkdir $(DESTDIR)$(mandir)/man3 ; fi
	$(INSTALL_DATA) $(srcdir)/vacall.3 $(DESTDIR)$(mandir)/man3/vacall.3
	if [ ! -d $(DESTDIR)$(datadir) ] ; then mkdir $(DESTDIR)$(datadir) ; fi
	if [ ! -d $(DESTDIR)$(htmldir) ] ; then mkdir $(DESTDIR)$(htmldir) ; fi
	$(INSTALL_DATA) $(srcdir)/vacall.html $(DESTDIR)$(htmldir)/vacall.html

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
	$(RM) $(DESTDIR)$(libdir)/libvacall.a
	$(RM) $(DESTDIR)$(includedir)/vacall.h
	$(RM) $(DESTDIR)$(mandir)/man3/vacall.3
	$(RM) $(DESTDIR)$(htmldir)/vacall.html

minitests.o : $(srcdir)/minitests.c $(srcdir)/tests.c vacall.h
	$(CC) $(CFLAGS) $(INCLUDES) -c $(srcdir)/minitests.c

minitests.s : $(srcdir)/minitests.c $(srcdir)/tests.c vacall.h
	$(CC) $(CFLAGS) $(INCLUDES) -S $(srcdir)/minitests.c

minitests : minitests.o libvacall.a
	$(CC) $(CFLAGS) -x none minitests.o libvacall.a -o minitests

check : all minitests
	./minitests > minitests.out
	LC_ALL=C uniq -u < minitests.out > minitests.output.$(HOST)
	test '!' -s minitests.output.$(HOST)

tests.o : $(srcdir)/tests.c vacall.h
	$(CC) $(CFLAGS) $(INCLUDES) -c $(srcdir)/tests.c

tests.s : $(srcdir)/tests.c vacall.h
	$(CC) $(CFLAGS) $(INCLUDES) -S $(srcdir)/tests.c

tests : tests.o libvacall.a
	$(CC) $(CFLAGS) -x none tests.o libvacall.a -o tests

extracheck : all tests
	./tests > tests.out
	LC_ALL=C uniq -u < tests.out > tests.output.$(HOST)
	test '!' -s tests.output.$(HOST)

mostlyclean : clean

clean : force
	$(RM) *.o *.a core
	$(RM) vacall-i386.s vacall-sparc.s vacall-sparc64.s vacall-m68k.s vacall-mips.s vacall-mipsn32.s vacall-mips64.s vacall-arm.s
	$(RM) minitests.o minitests.s minitests minitests.out
	$(RM) tests.o tests.s tests tests.out

distclean : clean
	$(RM) config.status config.log config.cache Makefile vacall.h config.h minitests.output.* tests.output.*

maintainer-clean : distclean

force :

