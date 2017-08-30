# Makefile for ffcall

#### Start of system configuration section. ####

# Directories used by "make install":
prefix = /usr/local
local_prefix = /usr/local
exec_prefix = ${prefix}
libdir = ${exec_prefix}/lib
includedir = ${prefix}/include
mandir = ${prefix}/man

# Programs used by "make":
RM = rm -f


#### End of system configuration section. ####

SHELL = /bin/sh

all : force
	cd avcall; $(MAKE) all
	cd vacall; $(MAKE) all
	cd trampoline; $(MAKE) all
	cd callback; $(MAKE) all

install : force
	cd avcall; $(MAKE) install
	cd vacall; $(MAKE) install
	cd trampoline; $(MAKE) install
	cd callback; $(MAKE) install

installdirs : force
	cd avcall; $(MAKE) installdirs
	cd vacall; $(MAKE) installdirs
	cd trampoline; $(MAKE) installdirs
	cd callback; $(MAKE) installdirs

uninstall : force
	cd avcall; $(MAKE) uninstall
	cd vacall; $(MAKE) uninstall
	cd trampoline; $(MAKE) uninstall
	cd callback; $(MAKE) uninstall

check : force
	cd avcall; $(MAKE) check
	cd vacall; $(MAKE) check
	cd trampoline; $(MAKE) check
	cd callback; $(MAKE) check

extracheck : force
	cd avcall; $(MAKE) extracheck
	cd vacall; $(MAKE) extracheck
	cd trampoline; $(MAKE) extracheck
	cd callback; $(MAKE) extracheck

mostlyclean : force
	cd avcall; $(MAKE) mostlyclean
	cd vacall; $(MAKE) mostlyclean
	cd trampoline; $(MAKE) mostlyclean
	cd callback; $(MAKE) mostlyclean

clean : force
	cd avcall; $(MAKE) clean
	cd vacall; $(MAKE) clean
	cd trampoline; $(MAKE) clean
	cd callback; $(MAKE) clean

distclean : force
	cd avcall; if test -f Makefile; then $(MAKE) distclean; fi
	cd vacall; if test -f Makefile; then $(MAKE) distclean; fi
	cd trampoline; if test -f Makefile; then $(MAKE) distclean; fi
	cd callback; if test -f Makefile; then $(MAKE) distclean; fi
	$(RM) config.status config.log config.cache Makefile

maintainer-clean : force
	cd avcall; if test -f Makefile; then $(MAKE) maintainer-clean; fi
	cd vacall; if test -f Makefile; then $(MAKE) maintainer-clean; fi
	cd trampoline; if test -f Makefile; then $(MAKE) maintainer-clean; fi
	cd callback; if test -f Makefile; then $(MAKE) maintainer-clean; fi
	$(RM) config.status config.log config.cache Makefile

force :

