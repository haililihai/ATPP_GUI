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
LIBTOOL = $(SHELL) $(top_builddir)/libtool
LIBTOOL_COMPILE = $(LIBTOOL) --mode=compile
LIBTOOL_LINK = $(LIBTOOL) --mode=link
LIBTOOL_INSTALL = $(LIBTOOL) --mode=install
LIBTOOL_UNINSTALL = $(LIBTOOL) --mode=uninstall
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

# Needed by $(LIBTOOL).
top_builddir = .

OBJECTS = trampoline.lo 

all : $(OBJECTS) libtrampoline.la trampoline_r.h $(srcdir)/trampoline_r.3 $(srcdir)/trampoline_r.html

trampoline_r.h : $(srcdir)/trampoline_r.h.in
	-$(LN_S) $(srcdir)/trampoline_r.h.in trampoline_r.h

trampoline.lo : $(srcdir)/trampoline.c trampoline_r.h
	$(LIBTOOL_COMPILE) $(CC) $(CFLAGS) $(INCLUDES) -c $(srcdir)/trampoline.c

tramp-hppa.lo : $(srcdir)/tramp-hppa.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c $(srcdir)/tramp-hppa.s

tramp-s390.lo : $(srcdir)/tramp-s390.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c $(srcdir)/tramp-s390.s

tramp-rs6000.lo : tramp-rs6000.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c tramp-rs6000.s

tramp-rs6000.s : $(srcdir)/tramp-rs6000.old.S $(srcdir)/tramp-rs6000.new.S
	case "$(OS)" in \
	  aix3*) syntax=old;; \
	  *) syntax=new;; \
	esac; \
	$(CPP) $(srcdir)/tramp-rs6000.$${syntax}.S > tramp-rs6000.s

tramp-ia64.lo : $(srcdir)/tramp-ia64.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c $(srcdir)/tramp-ia64.s

cache-sparc.lo : cache-sparc.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c cache-sparc.s

cache-sparc.s : $(srcdir)/cache-sparc.S
	$(CPP) $(ASPFLAGS) $(srcdir)/cache-sparc.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//.*$$,,' -e 's,\$$,#,g' > cache-sparc.s

cache-sparc64.lo : cache-sparc64.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c cache-sparc64.s

cache-sparc64.s : $(srcdir)/cache-sparc.S
	$(CPP) $(ASPFLAGS) $(srcdir)/cache-sparc.S | grep -v '^ *#line' | grep -v '^#' | sed -e 's,% ,%,g' -e 's,//.*$$,,' -e 's,\$$,#,g' > cache-sparc64.s

cache-alpha.lo : $(srcdir)/cache-alpha.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c $(srcdir)/cache-alpha.s

cache-hppa.lo : $(srcdir)/cache-hppa.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c $(srcdir)/cache-hppa.s

cache-rs6000.lo : $(srcdir)/cache-rs6000-sysv4.s $(srcdir)/cache-rs6000-macos.s
	case "$(OS)" in \
	  macos* | darwin*) syntax=macos;; \
	  *) syntax=sysv4;; \
	esac; \
	$(LIBTOOL_COMPILE) $(CC) -x none -c $(srcdir)/cache-rs6000-$${syntax}.s ; mv -f cache-rs6000-$${syntax}.o cache-rs6000.o ; mv -f cache-rs6000-$${syntax}.lo cache-rs6000.lo

cache-convex.lo : $(srcdir)/cache-convex.s
	$(LIBTOOL_COMPILE) $(CC) -x none -c $(srcdir)/cache-convex.s

libtrampoline.la : $(OBJECTS)
	$(LIBTOOL_LINK) $(CC) -o libtrampoline.la -rpath $(libdir) $(OBJECTS)

# Installs the library and include files only. Typically called with only
# $(libdir) and $(includedir) - don't use $(prefix) and $(exec_prefix) here.
install-lib : all force
	if [ ! -d $(includedir) ] ; then mkdir $(includedir) ; fi
	$(INSTALL_DATA) trampoline_r.h $(includedir)/trampoline_r.h

install : all force
	if [ ! -d $(DESTDIR)$(prefix) ] ; then mkdir $(DESTDIR)$(prefix) ; fi
	if [ ! -d $(DESTDIR)$(exec_prefix) ] ; then mkdir $(DESTDIR)$(exec_prefix) ; fi
#	if [ ! -d $(DESTDIR)$(libdir) ] ; then mkdir $(DESTDIR)$(libdir) ; fi
#	$(LIBTOOL_INSTALL) $(INSTALL_DATA) libtrampoline.la $(DESTDIR)$(libdir)/libtrampoline.la
	if [ ! -d $(DESTDIR)$(includedir) ] ; then mkdir $(DESTDIR)$(includedir) ; fi
	$(INSTALL_DATA) trampoline_r.h $(DESTDIR)$(includedir)/trampoline_r.h
	if [ ! -d $(DESTDIR)$(mandir) ] ; then mkdir $(DESTDIR)$(mandir) ; fi
	if [ ! -d $(DESTDIR)$(mandir)/man3 ] ; then mkdir $(DESTDIR)$(mandir)/man3 ; fi
	$(INSTALL_DATA) $(srcdir)/trampoline_r.3 $(DESTDIR)$(mandir)/man3/trampoline_r.3
	if [ ! -d $(DESTDIR)$(datadir) ] ; then mkdir $(DESTDIR)$(datadir) ; fi
	if [ ! -d $(DESTDIR)$(htmldir) ] ; then mkdir $(DESTDIR)$(htmldir) ; fi
	$(INSTALL_DATA) $(srcdir)/trampoline_r.html $(DESTDIR)$(htmldir)/trampoline_r.html

installdirs : force
	if [ ! -d $(DESTDIR)$(prefix) ] ; then mkdir $(DESTDIR)$(prefix) ; fi
	if [ ! -d $(DESTDIR)$(exec_prefix) ] ; then mkdir $(DESTDIR)$(exec_prefix) ; fi
#	if [ ! -d $(DESTDIR)$(libdir) ] ; then mkdir $(DESTDIR)$(libdir) ; fi
	if [ ! -d $(DESTDIR)$(includedir) ] ; then mkdir $(DESTDIR)$(includedir) ; fi
	if [ ! -d $(DESTDIR)$(mandir) ] ; then mkdir $(DESTDIR)$(mandir) ; fi
	if [ ! -d $(DESTDIR)$(mandir)/man3 ] ; then mkdir $(DESTDIR)$(mandir)/man3 ; fi
	if [ ! -d $(DESTDIR)$(datadir) ] ; then mkdir $(DESTDIR)$(datadir) ; fi
	if [ ! -d $(DESTDIR)$(htmldir) ] ; then mkdir $(DESTDIR)$(htmldir) ; fi

uninstall : force
#	$(LIBTOOL_UNINSTALL) $(RM) $(DESTDIR)$(libdir)/libtrampoline.la
	$(RM) $(DESTDIR)$(includedir)/trampoline_r.h
	$(RM) $(DESTDIR)$(mandir)/man3/trampoline_r.3
	$(RM) $(DESTDIR)$(htmldir)/trampoline_r.html

test1.o : $(srcdir)/test1.c trampoline_r.h
	$(CC) $(CFLAGS) $(INCLUDES) -c $(srcdir)/test1.c

test1 : test1.o $(OBJECTS)
	$(LIBTOOL_LINK) $(CC) $(CFLAGS) -x none test1.o $(OBJECTS) -o test1

test2.o : $(srcdir)/test2.c trampoline_r.h
	$(CC) $(CFLAGS) $(INCLUDES) -c $(srcdir)/test2.c

test2 : test2.o $(OBJECTS)
	$(LIBTOOL_LINK) $(CC) $(CFLAGS) -x none test2.o $(OBJECTS) -o test2

check1 : all test1
	./test1

check : all test1 test2
	./test1
	./test2
	touch tests.passed.$(HOST)

extracheck : check

mostlyclean : clean

clean : force
	$(RM) $(OBJECTS) `echo $(OBJECTS) | sed -e 's/\.lo/.o/g'` tramp-rs6000.s cache-sparc.s cache-sparc64.s libtrampoline.* core
	$(RM) -r .libs _libs
	$(RM) test1.o test1 test2.o test2

distclean : clean
	$(RM) config.status config.log config.cache Makefile config.h trampoline_r.h libtool tests.passed.*

maintainer-clean : distclean

force :


