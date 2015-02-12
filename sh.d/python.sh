#!/bin/sh
#
# Copyright (C) 2011, 2012, 2013, 2015 by Massimo Lauria
#
# Created   : "2011-09-22, Thursday 01:06 (CEST) Massimo Lauria"
# Time-stamp: "2015-02-13, 00:06 (CET) Massimo Lauria"
#
# Description::
#
# Shell environmnet variables for python, ipython, sagemath
#

# Code::

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


# Setup virtual envs
export WORKON_HOME=$HOME/.virtualenvs
if type virtualenvwrapper_lazy.sh > /dev/null; then
    source `which virtualenvwrapper_lazy.sh`
fi

# Local Variables:
# fill-column: 80
# End:
