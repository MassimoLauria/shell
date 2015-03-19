#!/bin/sh
#
# Copyright (C) 2011, 2014, 2015 by Massimo Lauria
#
# Created   : "2011-11-17, Thursday 20:43 (CET) Massimo Lauria"
# Time-stamp: "2015-03-19, 17:52 (CET) Massimo Lauria"
#
# Description::
#
# Some commands in ZSH requires specific aliases, especially to
# inhibit globbing of patterns.
#

# Code::

# Asterisks in scp commands would be globbed by zsh, which is VERY
# annoying.
alias scp="noglob scp"

alias dirs="dirs -v"



function o {
    if [ `uname` = "Linux" ]; then

        # by default open current folder
        if [ $# -lt 1 ]; then
            nohup pcmanfm .  </dev/null &>/dev/null 
        elif [ -d "$1" ]; then
            nohup pcmanfm $1 </dev/null &>/dev/null
        else
            nohup mimeopen $1 </dev/null &>/dev/null
        fi
    elif [ `uname` = "Darwin"]; then

        if [ $# -lt 1 ]; then
            open .
        else
            open $@
        fi

    else
        echo "Not implemented on this platform"
    fi
}


# Local Variables:
# fill-column: 80
# End:
