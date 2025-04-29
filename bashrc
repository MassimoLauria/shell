#!/bin/bash

# If not running interactively, don't do anything:
[ -z "$PS1" ] && return

case "$TERM" in
    xterm*|rxvt*|eterm*)
        PS1='\w $ '
        ;;
    *)
        PS1='$ '
        ;;
esac

# run my shell setup scripts
sh_sources=$HOME/config/shell/sh.d/

for sh_snippet in $sh_sources/*.sh; do
    source $sh_snippet
done

# private setup
[ -f "$HOME/personal/conf/shenv-personal" ] && \
    source $HOME/personal/conf/shenv-personal

umask 0077
