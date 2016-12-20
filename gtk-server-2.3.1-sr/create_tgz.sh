#!/bin/sh
#
# Create Slackware/Gentoo/Zenwalk package
# Peter van Eerten, peter@gtk-server.org
#
#---------------------------------------

VERSION=$1
PKG_NAME=gtk-server-$1-i386-1pve
if [ -z $1 ]
then
	echo "---> Provide version number <---"
	exit
fi

#---------------------------------------

USER=`whoami`
if [ $USER != "root" ]
then
	echo "Only root can create a package."
	exit
fi

#---------------------------------------

if [ -d slackpack ]
then
	echo "Warning: temporary directory 'slackpack' exists!"
	exit
fi

#---------------------------------------

echo "Creating Slack package..."
# Configfile
mkdir -p slackpack/etc
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
' gtk-server.cfg > slackpack/etc/gtk-server.cfg;
chmod 644 slackpack/etc/gtk-server.cfg
# Manpages
mkdir -p slackpack/usr/man/man1
cp docs/gtk-server.1 slackpack/usr/man/man1/
chmod 644 slackpack/usr/man/man1/gtk-server.1
cp docs/gtk-server.cfg.1 slackpack/usr/man/man1/
chmod 644 slackpack/usr/man/man1/gtk-server.cfg.1
cp docs/stop-gtk-server.1 slackpack/usr/man/man1/
chmod 644 slackpack/usr/man/man1/stop-gtk-server.1
gzip slackpack/usr/man/man1/gtk-server.1
gzip slackpack/usr/man/man1/gtk-server.cfg.1
gzip slackpack/usr/man/man1/stop-gtk-server.1
# Documentation + license
mkdir -p slackpack/usr/doc/gtk-server-$VERSION
cp docs/*.html slackpack/usr/doc/gtk-server-$VERSION/
chmod 444 slackpack/usr/doc/gtk-server-$VERSION/*.html
cp demo-gtk/* slackpack/usr/doc/gtk-server-$VERSION/
chmod 755 slackpack/usr/doc/gtk-server-$VERSION/demo*
cp README.1ST slackpack/usr/doc/gtk-server-$VERSION/
chmod 444 slackpack/usr/doc/gtk-server-$VERSION/README.1ST
cp CREDITS slackpack/usr/doc/gtk-server-$VERSION/
chmod 444 slackpack/usr/doc/gtk-server-$VERSION/CREDITS
cp GPL.txt slackpack/usr/doc/gtk-server-$VERSION/
chmod 444 slackpack/usr/doc/gtk-server-$VERSION/GPL.txt
# Binary
mkdir slackpack/usr/bin
chown root:bin slackpack/usr/bin/
cp gtk-server slackpack/usr/bin/
chmod 755 slackpack/usr/bin/gtk-server
chown root:bin slackpack/usr/bin/gtk-server
cp stop-gtk-server slackpack/usr/bin/
chmod 755 slackpack/usr/bin/stop-gtk-server
chown root:bin slackpack/usr/bin/stop-gtk-server
# Library
mkdir slackpack/usr/lib
cp libgtk-server.so slackpack/usr/lib/
chmod 755 slackpack/usr/lib/libgtk-server.so
# Add description
mkdir -p slackpack/install
echo "gtk-server: GTK-server $VERSION - Interpreted GUI Programming" >> slackpack/install/slack-desc
echo "gtk-server:" >> slackpack/install/slack-desc
echo "gtk-server: The GTK-server offers a stream-oriented interface to the GTK" >> slackpack/install/slack-desc
echo "gtk-server: libraries, enabling access to graphical user interfaces" >> slackpack/install/slack-desc
echo "gtk-server: for shell scripts and interpreted programming languages." >> slackpack/install/slack-desc
echo "gtk-server: It was inspired by Sun's DeskTop KornShell (dtksh) of" >> slackpack/install/slack-desc
echo "gtk-server: the Common Desktop Enviroment(CDE) for Unix." >> slackpack/install/slack-desc
echo "gtk-server:" >> slackpack/install/slack-desc
echo "gtk-server: More info at http://www.gtk-server.org/" >> slackpack/install/slack-desc
echo "gtk-server:" >> slackpack/install/slack-desc
echo "gtk-server: Package Created By: Peter van Eerten" >> slackpack/install/slack-desc

# Create package
cd slackpack
makepkg -c n $PKG_NAME.tgz

# Save package, remove temp dir
cd ..
mv slackpack/$PKG_NAME.tgz .
rm -rf slackpack/

# Exit
echo "Ready."
