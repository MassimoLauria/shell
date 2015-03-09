#!/bin/sh

mathpath=/Applications/Mathematica.app/Contents/MacOS/MathKernel

if [ -x $mathpath  ]; then
    if type rlwrap >/dev/null; then
        alias math="rlwrap $mathpath"
    else
        alias math=$mathpath
    fi 
fi
