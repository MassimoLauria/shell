#!/bin/sh
#
# Copyright (C) 2011, 2012, 2013, 2015, 2017 by Massimo Lauria
#
# Created   : "2011-09-22, Thursday 01:06 (CEST) Massimo Lauria"
# Time-stamp: "2017-09-27, 20:07 (CEST) Massimo Lauria"
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

# Setup anaconda path if Anaconda is installed
if [ -d $HOME/anaconda3/ ]; then
    export PATH="$HOME/anaconda3/bin:$PATH"
fi


# Local Variables:
# fill-column: 80
# End:
