# Makefile for trampoline

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
RM = rm -f
LN_S = ln -s


# Programs used by "make install":
INSTALL = /usr/bin/install -c
INSTALL_PROGRAM = $(INSTALL)
INSTALL_DATA = $(INSTALL) -m 644

#### End of system configuration section. ####

SHELL = /bin/sh

OBJECTS = trampoline.o 

all : $(OBJECTS) libtrampoline.a trampoline.h $(srcdir)/trampoline.3 $(srcdir)/trampoline.html

trampoline.h : $(srcdir)/trampoline.h.in
	-$(LN_S) $(srcdir)/trampoline.h.in trampoline.h

trampoline.o : $(srcdir)/trampoline.c trampoline.h
	$(CC) $(CFLAGS) $(INCLUDES) -c $(srcdir)/trampoline.c

tramp-hppa.o : $(srcdir)/tramp-hppa.s
	$(CC) -x none -c $(srcdir)/tramp-hppa.s

tramp-s390.o : $(srcdir)/tramp-s390.s
	$(CC) -x none -c $(srcdir)/tramp-s390.s

tramp-rs6000.o : tramp-rs6000.s
	$(CC) -x none -c tramp-rs6000.s

tramp-rs6000.s : $(srcdir)/tramp-rs6000.old.S $(srcdir)/tramp-rs6000.new.S
	case "$(OS)" in \
	  aix3*) syntax=old;; \
	  *) syntax=new;; \
	esac; \
	$(CPP) $(srcdir)/tramp-rs6000.$${syntax}.S > tramp-rs6000.s

tramp-ia64.o : $(srcdir)/tramp-ia64.s
	$(CC) -x none -c $(srcdir)/tramp-ia64.s

cache-sparc.o : cache-sparc.s
	$(CC) -x none -c cache-sparc.s

cache-sparc.s : $(srcdir)/cache-sparc.S
	$(CPP) $(ASPFLAGS) $(srcdir)/cache-sparc.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//.*$$,,' -e 's,\$$,#,g' > cache-sparc.s

cache-sparc64.o : cache-sparc64.s
	$(CC) -x none -c cache-sparc64.s

cache-sparc64.s : $(srcdir)/cache-sparc.S
	$(CPP) $(ASPFLAGS) $(srcdir)/cache-sparc.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//.*$$,,' -e 's,\$$,#,g' > cache-sparc64.s

cache-alpha.o : $(srcdir)/cache-alpha.s
	$(CC) -x none -c $(srcdir)/cache-alpha.s

cache-hppa.o : $(srcdir)/cache-hppa.s
	$(CC) -x none -c $(srcdir)/cache-hppa.s

cache-rs6000.o : $(srcdir)/cache-rs6000-sysv4.s $(srcdir)/cache-rs6000-macos.s
	case "$(OS)" in \
	  macos* | darwin*) syntax=macos;; \
	  *) syntax=sysv4;; \
	esac; \
	$(CC) -x none -c $(srcdir)/cache-rs6000-$${syntax}.s ; mv cache-rs6000-$${syntax}.o cache-rs6000.o

cache-convex.o : $(srcdir)/cache-convex.s
	$(CC) -x none -c $(srcdir)/cache-convex.s

libtrampoline.a : $(OBJECTS)
	$(RM) libtrampoline.a
	$(AR) $(AR_FLAGS) libtrampoline.a $(OBJECTS)
	$(RANLIB) libtrampoline.a

install : all force
	if [ ! -d $(DESTDIR)$(prefix) ] ; then mkdir $(DESTDIR)$(prefix) ; fi
	if [ ! -d $(DESTDIR)$(exec_prefix) ] ; then mkdir $(DESTDIR)$(exec_prefix) ; fi
	if [ ! -d $(DESTDIR)$(libdir) ] ; then mkdir $(DESTDIR)$(libdir) ; fi
	$(INSTALL_DATA) libtrampoline.a $(DESTDIR)$(libdir)/libtrampoline.a
	if [ ! -d $(DESTDIR)$(includedir) ] ; then mkdir $(DESTDIR)$(includedir) ; fi
	$(INSTALL_DATA) trampoline.h $(DESTDIR)$(includedir)/trampoline.h
	if [ ! -d $(DESTDIR)$(mandir) ] ; then mkdir $(DESTDIR)$(mandir) ; fi
	if [ ! -d $(DESTDIR)$(mandir)/man3 ] ; then mkdir $(DESTDIR)$(mandir)/man3 ; fi
	$(INSTALL_DATA) $(srcdir)/trampoline.3 $(DESTDIR)$(mandir)/man3/trampoline.3
	if [ ! -d $(DESTDIR)$(datadir) ] ; then mkdir $(DESTDIR)$(datadir) ; fi
	if [ ! -d $(DESTDIR)$(htmldir) ] ; then mkdir $(DESTDIR)$(htmldir) ; fi
	$(INSTALL_DATA) $(srcdir)/trampoline.html $(DESTDIR)$(htmldir)/trampoline.html

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
	$(RM) $(DESTDIR)$(libdir)/libtrampoline.a
	$(RM) $(DESTDIR)$(includedir)/trampoline.h
	$(RM) $(DESTDIR)$(mandir)/man3/trampoline.3
	$(RM) $(DESTDIR)$(htmldir)/trampoline.html

test1.o : $(srcdir)/test1.c trampoline.h
	$(CC) $(CFLAGS) $(INCLUDES) -c $(srcdir)/test1.c

test1 : test1.o $(OBJECTS)
	$(CC) $(CFLAGS) -x none test1.o $(OBJECTS) -o test1

test2.o : $(srcdir)/test2.c trampoline.h
	$(CC) $(CFLAGS) $(INCLUDES) -c $(srcdir)/test2.c

test2 : test2.o $(OBJECTS)
	$(CC) $(CFLAGS) -x none test2.o $(OBJECTS) -o test2

check1 : all test1
	./test1

check : all test1 test2
	./test1
	./test2
	touch tests.passed.$(HOST)

extracheck : check

mostlyclean : clean

clean : force
	$(RM) $(OBJECTS) tramp-rs6000.s cache-sparc.s cache-sparc64.s libtrampoline.a core
	$(RM) test1.o test1 test2.o test2

distclean : clean
	$(RM) config.status config.log config.cache Makefile config.h trampoline.h tests.passed.*

maintainer-clean : distclean

force :


