#!/bin/sh
#
# Copyright (C) 2011, 2012, 2013, 2015, 2017, 2018, 2020 by Massimo Lauria
#
# Created   : "2011-09-22, Thursday 01:06 (CEST) Massimo Lauria"
# Time-stamp: "2020-04-27, 13:43 (CEST) Massimo Lauria"
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
if [ -d $HOME/.pyenv/ ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi

# Local Variables:
# fill-column: 80
# End:
