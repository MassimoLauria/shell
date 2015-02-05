#!/bin/sh
#
# Copyright (C) 2011, 2012, 2013 by Massimo Lauria
#
# Created   : "2011-09-22, Thursday 01:06 (CEST) Massimo Lauria"
# Time-stamp: "2013-12-30, 05:37 (CET) Massimo Lauria"
#
# Description::
#
# Shell environmnet variables for Haskell platform
#

# Code::


HASKELLSYSDIR=$HOME/Library/Haskell
CABALUSERDIR=$HOME/.cabal

# Additional Path from macosx haskell installation
# this is easier to integrate with macosx tools than macport version.
if [ `uname` = "Darwin" ]; then
    PATH=$HASKELLSYSDIR/bin:$PATH
fi


# local cabal installation
if [ -d $CABALUSERDIR ]; then
    PATH=$CABALUSERDIR/bin:$PATH
fi


# Local Variables:
# fill-column: 80
# End:
