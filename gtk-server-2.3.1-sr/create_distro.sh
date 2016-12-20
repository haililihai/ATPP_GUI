#!/bin/sh
#
# Cleanup mess and generate source distribution file
# Peter van Eerten, peter@gtk-server.org
#
VERSION=$1
DIR=gtk-server-$1
if [ -z $1 ]
then
    echo "---> Provide version number: x.y.z <---"
    exit
fi
make delete >/dev/null 2>&1
rm -f gtk-server
rm -f libgtk-server.so
rm -f config.h
rm -f config.log
rm -f config.status
rm -f configure
rm -f Makefile
rm -f *.tar.gz
if [ ! -f $DIR.spec ]
then
    mv *.spec $DIR.spec
fi
autoconf
rm -rf autom4te.cache
touch *
touch */*
mkdir $DIR
cp * $DIR/ > /dev/null 2>&1
mkdir $DIR/demo-gtk/
cp demo-gtk/* $DIR/demo-gtk/
mkdir $DIR/demo-xf/
cp demo-xf/* $DIR/demo-xf/
mkdir $DIR/hug/
cp hug/* $DIR/hug/
mkdir $DIR/other/
cp other/* $DIR/other/
mkdir $DIR/docs/
cp docs/* $DIR/docs/
mkdir $DIR/s-lang
cp s-lang/demo-lib.sl $DIR/s-lang
cp s-lang/GTK_SERVER_README.1ST $DIR/s-lang
mkdir $DIR/ksh93
cp ksh93/demo-lib.ksh $DIR/ksh93
cp ksh93/GTK_SERVER_README.1ST $DIR/ksh93
mkdir $DIR/scriptbasic
cp scriptbasic/* $DIR/scriptbasic
tar -cf $DIR.tar $DIR/
rm -rf $DIR
gzip $DIR.tar
echo "Distribution ready."
