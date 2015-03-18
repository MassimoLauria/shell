#!/bin/sh
#
# Copyright (C) 2011, 2014, 2015 by Massimo Lauria
#
# Created   : "2011-11-17, Thursday 20:43 (CET) Massimo Lauria"
# Time-stamp: "2015-03-18, 02:20 (CET) Massimo Lauria"
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


if [ `uname` = "Linux" ]; then
    alias open=xdg-open
fi

function o {
    if [ $# -lt 1 ]; then
        open .
    else
        open $@
    fi
}


# Local Variables:
# fill-column: 80
# End:
