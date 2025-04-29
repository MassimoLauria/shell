#!/bin/bash

# If not running interactively, don't do anything:
[ -z "$PS1" ] && return

# If this is an xterm set the title to user@host:dir
case "$TERM" in
    "dumb")
        PS1='$ '
        ;;
    xterm*|rxvt*|eterm*)
        PS1='\u@\h:\w$ '
        ;;
    *)
        PS1='$ '
        ;;
esac

source ~/config/shell/shenv-common
