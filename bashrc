#!/bin/bash
# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything:
[ -z "$PS1" ] && return

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if [ "$TERM" != "dumb" ]; then
    eval "`dircolors -b`"
    alias ls='ls --color=auto'
fi


# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" -a -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi


PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: ${PWD}\007"'
    ;;
*)
    ;;
esac

## User added stuff
umask 027
alias rm="rm -iv"


## Editor configuration
EMACSSERVER="massimo"
EDITOR="ec"


if [ `which emacs-console` ];then
    ALTERNATE_EDITOR=emacs-console
elif [ `which qemacs` ]; then
    ALTERNATE_EDITOR=qemacs
elif [ `which vim` ]; then
    ALTERNATE_EDITOR=vim
else
    ALTERNATE_EDITOR=vi
fi

alias ec="emacsclient -t -s $EMACSSERVER"
alias ecx="emacsclient -c -s $EMACSSERVER"
alias listemacs='ps auwwx | grep emacs | grep SCREEN | cut -d "\"" -f 2'

export EDITOR
export ALTERNATE_EDITOR
export PAGER=/usr/bin/most


# Make sure our customised gtkrc file is loaded.
export GTK2_RC_FILES=$HOME/.gtkrc-2.0

# GnuPG Agent loading
GPG_TTY=$(tty)
export GPG_TTY
if [ -f "${HOME}/.gnupg/gpg-agent-info-$(hostname)" ]; then
    . "${HOME}/.gnupg/gpg-agent-info-$(hostname)"
    export GPG_AGENT_INFO
    #export SSH_AUTH_SOCK
    #export SSH_AGENT_PID
fi

