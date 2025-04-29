#!/bin/bash

# If not running interactively, don't do anything:
[ -z "$PS1" ] && return

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*|eterm*)
        PS1='\w $ '
        ;;
    *)
        PS1='$ '
        ;;
esac

sh_sources=~/config/shell/sh.d/

for sh_snippet in $sh_sources/*.sh; do
    source $sh_snippet
done
