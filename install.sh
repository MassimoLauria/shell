#!/bin/sh

# Copyright (C) 2010, 2011, 2012, 2024 by Massimo Lauria <lauria.massimo@gmail.com>
#
# Created   : "2011-03-05, sabato 01:03 (CET) Massimo Lauria"
# Time-stamp: "2024-07-27, 15:51 (CEST) Massimo Lauria"

# Description::
#
# Install file to setup the shell.

# -------------------- Env Variables ------------------------
RCFILES="bashrc zshrc inputrc screenrc profile"
DESTDIR="$HOME"
CONFPATH="${HOME}/config/shell/"

# Do install
for FILENAME in $RCFILES; do
    echo "Linking '$CONFPATH/$FILENAME' in '$DESTDIR/.$FILENAME'"
    rm -f $DESTDIR/.$FILENAME
    ln -s $CONFPATH/$FILENAME $DESTDIR/.$FILENAME
done
echo "Bye, bye!"
