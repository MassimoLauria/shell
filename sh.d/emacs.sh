#!/bin/sh
#
# Massimo Lauria, 2015
#
# Shell configuration for Emacs/Editor
#


#
# Find Emacs on MacOSX
#
if [ `uname` = "Darwin" ]; then
    for emacsapp in Emacs.app Aquamacs.app; do
        if [ -d "/Applications/$emacsapp" ]; then
            emacsbin="/Applications/$emacsapp/Contents/MacOS/Emacs"
            emacsclient="/Applications/$emacsapp/Contents/MacOS/bin/emacsclient"
            break
        fi
    done
    emacsclient_opts=""
else
    emacsbin="emacs"
    emacsclient="emacsclient"
    emacsclient_opts=" -t"
fi


# Make it accessible from the shell
if [ "$emacsbin" != "emacs" ]; then
   EMACS="$emacsbin"
   alias emacs="$emacsbin"
   alias emacsclient="$emacsclient"
fi


EDITOR="$emacsclient$emacsclient_opts"
GIT_EDITOR="$emacsclient$emacsclient_opts"

alias ec="$emacsclient$emacsclient_opts"
alias ecx="$emacsclient -n -c"


# Fallback Editor
if type vim >/dev/null 2>&1; then
    ALTERNATE_EDITOR="vim"
else
    ALTERNATE_EDITOR="vi"
fi


export EMACS
export EDITOR
export ALTERNATE_EDITOR
export GIT_EDITOR


# Cask path
export PATH="$HOME/.cask/bin:$PATH"
