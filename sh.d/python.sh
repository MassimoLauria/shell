#!/bin/sh
#
# Copyright (C) 2011, 2012, 2013, 2015, 2017, 2018, 2020, 2021, 2024 by Massimo Lauria
#
# Created   : "2011-09-22, Thursday 01:06 (CEST) Massimo Lauria"
# Time-stamp: "2024-07-27, 15:58 (CEST) Massimo Lauria"
#
# Description::
#
# Shell environmnet variables for python, ipython, sagemath
#

# Code::

# Python enviroment variables
PYTHONSTARTUP=$CONFIGDIR/python/pythonrc.py
if [ -f $PYTHONSTARTUP ]; then
    export PYTHONSTARTUP
fi

IPYTHONDIR=$HOME/.ipython/
export IPYTHONDIR

MPLCONFIGDIR=$HOME/.matplotlib/
export MPLCONFIGDIR

# Local Variables:
# fill-column: 80
# End:
