#!/bin/sh
#
# Copyright (C) 2011, 2012, 2013, 2015, 2017, 2018 by Massimo Lauria
#
# Created   : "2011-09-22, Thursday 01:06 (CEST) Massimo Lauria"
# Time-stamp: "2018-06-19, 15:13 (CEST) Massimo Lauria"
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

IPYTHONDIR=$HOME/.ipython/
export IPYTHONDIR

# Setup pyenv if present
if [ -d $HOME/.pyenv/ ]; then
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
fi

# Setup anaconda path if Anaconda is installed
#
ACTIVATE_ANACONDA=no  # set to 'yes' to have anaconda in the path

if [ -d $HOME/anaconda3/ ]; then
    ANACONDA_PATH=$HOME/anaconda3/
elif [ -d $HOME/anaconda/ ]; then
    ANACONDA_PATH=$HOME/anaconda/
elif [ -d $HOME/Library/anaconda3/ ]; then
    ANACONDA_PATH=$HOME/Library/anaconda3
elif [ -d $HOME/Library/anaconda/ ]; then
    ANACONDA_PATH=$HOME/Library/anaconda
fi
    
if [ "$ACTIVATE_ANACONDA" = yes  -a -n "$ANACONDA_PATH" ]; then
    echo [ "$ACTIVATE_ANACONDA"==yes  -a -n "$ANACONDA_PATH" ]
    echo "anaconda is active $ACTIVATE_ANACONDA"
    export PATH=$ANACONDA_PATH/bin:$PATH
fi

# Local Variables:
# fill-column: 80
# End:
