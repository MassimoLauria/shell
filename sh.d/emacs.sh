#!/bin/sh
#
# Massimo Lauria, 2015
#
# Shell configuration for Emacs/Editor

if type emacs >/dev/null 2>&1; then

    EMACS=emacs
    EDITOR="emacsclient -t"
    GIT_EDITOR="emacsclient -t"

    alias ec="emacsclient -t"
    alias ecx="emacsclient -n -c"
    alias floatemacs="emacsclient -c --frame-parameters='(quote (name . \"floatemacs\") (height . 40) (width . 80))'"

    export EMACS
    export EDITOR
    export GIT_EDITOR

    function info {
        emacsclient -t -e "(info \"$1\")" -a nil || /usr/bin/info "$1"
    }

fi


# Fallback Editor
if type nano >/dev/null 2>&1; then
    ALTERNATE_EDITOR="nano"
elif type micro >/dev/null 2>&1; then
    ALTERNATE_EDITOR="micro"
elif type nvim >/dev/null 2>&1; then
    ALTERNATE_EDITOR="nvim"
elif type vim >/dev/null 2>&1; then
    ALTERNATE_EDITOR="vim"
else
    ALTERNATE_EDITOR="vi"
fi

export ALTERNATE_EDITOR
