#!/bin/zsh


# Here the colors for ls
if test -x =dircolors; then
    eval "`dircolors`"
    export LS_COLORS="*.ogm=01;35:${LS_COLORS}"
fi

