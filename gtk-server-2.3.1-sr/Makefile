prefix =	/usr/local
exec_prefix =	${prefix}
BINDIR =	${exec_prefix}/bin
LIBDIR = 	${exec_prefix}/lib
INCL =		${prefix}/include
SYSCONFIG =	${prefix}/etc
datarootdir =	@datarootdir@
MANDIR =	${prefix}/man
CC =		gcc
STRIP =		strip
CFLAGS =	-Wall -pedantic -pthread -ldl -I/usr/include/gtk-2.0 -I/usr/lib/x86_64-linux-gnu/gtk-2.0/include -I/usr/include/gio-unix-2.0/ -I/usr/include/cairo -I/usr/include/pango-1.0 -I/usr/include/atk-1.0 -I/usr/include/cairo -I/usr/include/pixman-1 -I/usr/include/libpng12 -I/usr/include/gdk-pixbuf-2.0 -I/usr/include/libpng12 -I/usr/include/pango-1.0 -I/usr/include/harfbuzz -I/usr/include/pango-1.0 -I/usr/include/glib-2.0 -I/usr/lib/x86_64-linux-gnu/glib-2.0/include -I/usr/include/freetype2 -fPIC  -DHAVE_CONFIG_H -DLOCALCFG=\"$(SYSCONFIG)/gtk-server.cfg\"
LDFLAGS =	-ldl -export-dynamic  -lavcall -lgtk-x11-2.0 -lgdk-x11-2.0 -lpangocairo-1.0 -latk-1.0 -lcairo -lgdk_pixbuf-2.0 -lgio-2.0 -lpangoft2-1.0 -lpango-1.0 -lgobject-2.0 -lglib-2.0 -lfontconfig -lfreetype -L/usr/lib64
OBJS =		gtk-server.o 
INSTALL = 	/usr/bin/install -c
TARGET =	gtk-server
DEFAULT = 	1
BACKEND =	GTK2
MACOSX =	no

all : clean $(TARGET)

gtk-server : $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)
	$(STRIP) $@

gtk-server.exe : $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)
	$(STRIP) $@

libgtk-server.so : $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)
	$(STRIP) $@
	ar -r libgtk-server.a $(OBJS)
	ranlib libgtk-server.a

libgtk-server.dylib : $(OBJS)
	$(CC) -o $@ $(OBJS) $(LDFLAGS)
	ar -r libgtk-server.a $(OBJS)
	ranlib libgtk-server.a

install : $(TARGET)
	@if [ $(DEFAULT) -eq "1" ]; then \
	    mkdir -p $(BINDIR); \
	    $(INSTALL) $(TARGET) $(BINDIR); \
	    echo "mkdir -p $(BINDIR)"; \
	    echo "$(INSTALL) $(TARGET) $(BINDIR)"; \
	fi;
	@if [ $(DEFAULT) -eq "2" ]; then \
	    mkdir -p $(LIBDIR); \
	    $(INSTALL) $(TARGET) $(LIBDIR); \
	    echo "mkdir -p $(LIBDIR)"; \
	    echo "$(INSTALL) $(TARGET) $(LIBDIR)"; \
	fi;
	$(INSTALL) stop-gtk-server $(BINDIR)
	mkdir -p $(SYSCONFIG)
	@if [ $(BACKEND) = "GTK1" ]; then \
	    echo "Creating configfile..."; \
	    awk ' \
		/# LIB_NAME = libgtk.so, libgdk.so, libglib.so, libglade.so/ {print "LIB_NAME = libgtk.so, libgdk.so, libglib.so, libglade.so"} \
		/# LIB_NAME = libX11.so, libglut.so, libGLU.so, libGL.so/ {print "LIB_NAME = libX11.so, libglut.so, libGLU.so, libGL.so"} \
		/# LIB_NAME = libncurses.so, libform.so, libpanel.so, libmenu.so/ {print "LIB_NAME = libncurses.so, libform.so, libpanel.so, libmenu.so"} \
		/# LIB_NAME = libm.so, libc.so.6/ {print "LIB_NAME = libm.so, libc.so.6"} \
		!/LIB_NAME/ {print} \
	    ' gtk-server.cfg > $(SYSCONFIG)/gtk-server.cfg; \
	    echo "Done."; \
	fi;
	@if [ $(BACKEND) = "GTK2" -a $(MACOSX) = "no" ]; then \
	    echo "Creating configfile..."; \
	    awk ' \
		/# LIB_NAME = libgtk-x11-2.0.so, libgdk-x11-2.0.so, libglib-2.0.so, libgobject-2.0.so/ {print "LIB_NAME = libgtk-x11-2.0.so, libgdk-x11-2.0.so, libglib-2.0.so, libgobject-2.0.so"} \
		/# LIB_NAME = libatk-1.0.so, libpango-1.0.so, libgdk_pixbuf_xlib-2.0.so/ {print "LIB_NAME = libatk-1.0.so, libpango-1.0.so, libgdk_pixbuf_xlib-2.0.so"} \
		/# LIB_NAME = libglade-2.0.so/ {print "LIB_NAME = libglade-2.0.so"} \
		/# LIB_NAME = libgtkgl-2.0.so, libgtkglext-x11-1.0.so, libgdkglext-x11-1.0.so/ {print "LIB_NAME = libgtkgl-2.0.so, libgtkglext-x11-1.0.so, libgdkglext-x11-1.0.so"} \
		/# LIB_NAME = libX11.so, libglut.so, libGLU.so, libGL.so/ {print "LIB_NAME = libX11.so, libglut.so, libGLU.so, libGL.so"} \
		/# LIB_NAME = libgtkembedmoz.so/ {print "LIB_NAME = libgtkembedmoz.so"} \
		/# LIB_NAME = libpoppler-glib.so/ {print "LIB_NAME = libpoppler-glib.so"} \
		/# LIB_NAME = libncurses.so, libform.so, libpanel.so, libmenu.so/ {print "LIB_NAME = libncurses.so, libform.so, libpanel.so, libmenu.so"} \
		/# LIB_NAME = libm.so, libc.so.6/ {print "LIB_NAME = libm.so, libc.so.6"} \
		!/LIB_NAME/ {print} \
	    ' gtk-server.cfg > $(SYSCONFIG)/gtk-server.cfg; \
	    echo "Done."; \
	fi;
	@if [ $(BACKEND) = "GTK2" -a $(MACOSX) = "yes" ]; then \
	    echo "Creating configfile..."; \
	    awk ' \
		/# LIB_NAME = \/Library\/Frameworks\/Gtk.framework\/Libraries\/libgtk-quartz-2.0.0.dylib/ {print "LIB_NAME = /Library/Frameworks/Gtk.framework/Libraries/libgtk-quartz-2.0.0.dylib"} \
		/# LIB_NAME = \/Library\/Frameworks\/Gtk.framework\/Libraries\/libgdk-quartz-2.0.0.dylib/ {print "LIB_NAME = /Library/Frameworks/Gtk.framework/Libraries/libgdk-quartz-2.0.0.dylib"} \
		/# LIB_NAME = \/Library\/Frameworks\/GLib.framework\/Libraries\/libglib-2.0.0.dylib/ {print "LIB_NAME = /Library/Frameworks/GLib.framework/Libraries/libglib-2.0.0.dylib"} \
		/# LIB_NAME = \/Library\/Frameworks\/GLib.framework\/Libraries\/libgobject-2.0.0.dylib/ {print "LIB_NAME = /Library/Frameworks/GLib.framework/Libraries/libgobject-2.0.0.dylib"} \
		/# LIB_NAME = \/Library\/Frameworks\/Gtk.framework\/Libraries\/libatk-1.0.0.dylib/ {print "LIB_NAME = /Library/Frameworks/Gtk.framework/Libraries/libatk-1.0.0.dylib"} \
		/# LIB_NAME = \/Library\/Frameworks\/Gtk.framework\/Libraries\/libpango-1.0.0.dylib/ {print "LIB_NAME = /Library/Frameworks/Gtk.framework/Libraries/libpango-1.0.0.dylib"} \
		/# LIB_NAME = \/Library\/Frameworks\/Gtk.framework\/Libraries\/libgdk-pixbuf-2.0.0.dylib/ {print "LIB_NAME = /Library/Frameworks/Gtk.framework/Libraries/libgdk-pixbuf-2.0.0.dylib"} \
		/# LIB_NAME = libcurses.dylib, libform.dylib, libpanel.dylib, libmenu.dylib/ {print "LIB_NAME = libcurses.dylib, libform.dylib, libpanel.dylib, libmenu.dylib"} \
		/# LIB_NAME = \/System\/Library\/Frameworks\/OpenGL.Framework\/libraries\/libGL.dylib/ {print "LIB_NAME = /System/Library/Frameworks/OpenGL.Framework/libraries/libGL.dylib"} \
		/# LIB_NAME = \/System\/Library\/Frameworks\/GLUT.Framework\/GLUT/ {print "LIB_NAME = /System/Library/Frameworks/GLUT.Framework/GLUT"} \
		/# LIB_NAME = libm.dylib, libc.dylib/ {print "LIB_NAME = libm.dylib, libc.dylib"} \
		!/LIB_NAME/ {print} \
	    ' gtk-server.cfg > $(SYSCONFIG)/gtk-server.cfg; \
	    echo "Done."; \
	fi;
	@if [ $(BACKEND) = "XF" ]; then \
	    echo "Creating configfile..."; \
	    awk ' \
		/# LIB_NAME = libforms.so, libflimage.so, libformsGL.so/ {print "LIB_NAME = libforms.so, libflimage.so, libformsGL.so"} \
		/# LIB_NAME = libX11.so, libglut.so, libGLU.so, libGL.so/ {print "LIB_NAME = libX11.so, libglut.so, libGLU.so, libGL.so"} \
		/# LIB_NAME = libncurses.so, libform.so, libpanel.so, libmenu.so/ {print "LIB_NAME = libncurses.so, libform.so, libpanel.so, libmenu.so"} \
		/# LIB_NAME = libm.so, libc.so.6/ {print "LIB_NAME = libm.so, libc.so.6"} \
		!/LIB_NAME/ {print} \
	    ' gtk-server.cfg > $(SYSCONFIG)/gtk-server.cfg; \
	    echo "Done."; \
	fi;
	@if [ $(BACKEND) = "CONSOLE" -a $(MACOSX) = "no" ]; then \
	    echo "Creating configfile..."; \
	    awk ' \
		/# LIB_NAME = libncurses.so, libform.so, libpanel.so, libmenu.so/ {print "LIB_NAME = libncurses.so, libform.so, libpanel.so, libmenu.so"} \
		/# LIB_NAME = libm.so, libc.so.6/ {print "LIB_NAME = libm.so, libc.so.6"} \
		!/LIB_NAME/ {print} \
	    ' gtk-server.cfg > $(SYSCONFIG)/gtk-server.cfg; \
	    echo "Done."; \
	fi;
	@if [ $(BACKEND) = "CONSOLE" -a $(MACOSX) = "yes" ]; then \
	    echo "Creating configfile..."; \
	    awk ' \
		/# LIB_NAME = libcurses.dylib, libform.dylib, libpanel.dylib, libmenu.dylib/ {print "LIB_NAME = libcurses.dylib, libform.dylib, libpanel.dylib, libmenu.dylib"} \
		/# LIB_NAME = libm.dylib, libc.dylib/ {print "LIB_NAME = libm.dylib, libc.dylib"} \
		!/LIB_NAME/ {print} \
	    ' gtk-server.cfg > $(SYSCONFIG)/gtk-server.cfg; \
	    echo "Done."; \
	fi;
	mkdir -p $(MANDIR)/man1
	$(INSTALL) -m 644 docs/gtk-server.1 $(MANDIR)/man1
	$(INSTALL) -m 644 docs/gtk-server.cfg.1 $(MANDIR)/man1
	$(INSTALL) -m 644 docs/stop-gtk-server.1 $(MANDIR)/man1
	@if [ $(DEFAULT) -eq "3" ]; then \
		echo "Installing S-Lang module..."; \
		mv libgtk-server.so /usr/lib/gtk-module.so; \
		echo "mv libgtk-server.so /usr/lib/gtk-module.so"; \
	fi;
	@if [ $(DEFAULT) -eq "4" ]; then \
		echo "Installing Scriptbasic module..."; \
		mkdir -p $(LIBDIR); \
		mv libgtk-server.so $(LIBDIR)/gtk-server.so; \
		echo "mv libgtk-server.so $(LIBDIR)/gtk-server.so"; \
		mkdir -p $(INCL); \
		cp scriptbasic/gtk.bas $(INCL)/gtk.bas; \
		echo "cp scriptbasic/gtk.bas $(INCL)/gtk.bas"; \
	fi

uninstall:
	@if [ $(DEFAULT) -eq "1" ]; then \
		rm -f $(BINDIR)/$(TARGET); \
		echo "rm -f $(BINDIR)/$(TARGET)"; \
	fi;
	@if [ $(DEFAULT) -eq "2" ]; then \
		rm -f $(LIBDIR)/$(TARGET); \
		echo "rm -f $(LIBDIR)/$(TARGET)"; \
	fi;
	rm -f $(SYSCONFIG)/gtk-server.cfg
	rm -f $(BINDIR)/stop-gtk-server
	rm -f $(MANDIR)/man1/gtk-server.1
	rm -f $(MANDIR)/man1/gtk-server.cfg.1
	rm -f $(MANDIR)/man1/stop-gtk-server.1
	@if [ $(DEFAULT) -eq "3" ]; then \
		echo "Uninstalling S-Lang module..."; \
		rm -f /usr/lib/gtk-module.so; \
		echo "rm -f /usr/lib/gtk-module.so"; \
	fi;
	@if [ $(DEFAULT) -eq "4" ]; then \
		echo "Uninstalling Scriptbasic module..."; \
		rm -f $(LIBDIR)/gtk-server.so; \
		echo "rm -f $(LIBDIR)/gtk-server.so"; \
		rm -f $(INCL)/gtk.bas; \
		echo "rm -f $(INCL)/gtk.bas"; \
	fi

clean:
	rm -f $(TARGET) *.a *.o *.log so_locations

delete:
	rm -rf autom4te.cache/
	rm -f $(TARGET) *.a *.o *.log so_locations config.status config.h Makefile
