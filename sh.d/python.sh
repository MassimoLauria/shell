#!/bin/sh
#
# Copyright (C) 2011, 2012, 2013, 2015, 2017, 2018, 2020, 2021 by Massimo Lauria
#
# Created   : "2011-09-22, Thursday 01:06 (CEST) Massimo Lauria"
# Time-stamp: "2021-07-02, 12:44 (CEST) Massimo Lauria"
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


# Setup pyenv if present
export PYENV_ROOT="$HOME/.pyenv"
if [ -d $PYENV_ROOT ]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

# Local Variables:
# fill-column: 80
# End:
