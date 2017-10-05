#!/bin/sh
#
# Copyright (C) 2011, 2012, 2013, 2015, 2017 by Massimo Lauria
#
# Created   : "2011-09-22, Thursday 01:06 (CEST) Massimo Lauria"
# Time-stamp: "2017-10-05, 14:31 (CEST) Massimo Lauria"
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
if [ -f /usr/local/bin/python3 ]; then 
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
elif [ -f /usr/local/bin/python2 ]; then 
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python2
elif [ -f /usr/local/bin/python ]; then 
    export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
else
    export VIRTUALENVWRAPPER_PYTHON=python
fi

export WORKON_HOME=$HOME/.virtualenvs
if type virtualenvwrapper_lazy.sh >/dev/null 2>&1; then
    source `which virtualenvwrapper_lazy.sh`
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
else
    ANACONDA_PATH=''
fi
    
if [ -n $ANACONDA_PATH -a "$ACTIVATE_ANACONDA"=="yes" ]; then
    export PATH=$ANACONDA_PATH/bin:$PATH
fi

# Local Variables:
# fill-column: 80
# End:
