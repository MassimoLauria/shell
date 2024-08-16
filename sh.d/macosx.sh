#!/bin/sh

# Massimo Lauria, 2010, 2015
#
# Shell commands for MacOSX. This is because MacOSX has no Xsession.
#

if [ x`uname` != "xDarwin" ]; then return 0; fi # only for macosx



# SSH identity load
if [ -n "$SSHIDENTITY" -a -f "$SSHIDENTITY" ]; then
    ssh-add $SSHIDENTITY 2> /dev/null
fi

# color setup for BSD version of ls
CLICOLOR=1
LSCOLORS=ExFxCxDxBxegedabagacad
export CLICOLOR LSCOLORS

# Stop homebrew to update in the worst possible moment
export HOMEBREW_NO_AUTO_UPDATE=1
