#!/bin/sh
#
# Copyright (C) 2011, 2012, 2013 by Massimo Lauria
#
# Created   : "2011-09-22, Thursday 01:06 (CEST) Massimo Lauria"
# Time-stamp: "2013-12-01, 03:35 (CET) Massimo Lauria"
#
# Description::
#
# Shell environmnet variables for python, ipython, sagemath
#

# Code::

# Additional Path from local installation
if [ `uname` = "Darwin" ]; then
    PATH=$PATH:$HOME/Library/Python/2.7/bin/
fi


# Python enviroment variables
PYTHONSTARTUP=$CONFIGDIR/pythonrc/pythonrc.py
if [ -f $PYTHONSTARTUP ]; then
    export PYTHONSTARTUP
fi

# IPython configuration folder
# >= 0.12
IPYTHONDIR=$HOME/.ipython/
export IPYTHONDIR

# Sagemath configuration folder
DOT_SAGE=$HOME/.sage/
export DOT_SAGE


# Local Variables:
# fill-column: 80
# End:
