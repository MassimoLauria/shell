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

source ~/config/shell/shenv-common
