#!/bin/sh

if [ -x /Applications/Mathematica.app/Contents/MacOS/MathKernel ]; then
    mathpath=/Applications/Mathematica.app/Contents/MacOS/MathKernel
elif [ -x /pkg/mathematica/10.0.2/os/bin/MathKernel ]; then
    mathpath=/pkg/mathematica/10.0.2/os/bin/MathKernel
elif [ -x /usr/local/bin/math ]; then
    mathpath=/usr/local/bin/math
else
    mathpath=math
fi

if type rlwrap >/dev/null 2>&1; then
    alias math="rlwrap $mathpath"
else
    alias math=$mathpath
fi 
