#!/bin/sh

# Massimo Lauria, 2010
#
# Shell enviroment for GPG agent ...
#


# {{{ GnuPG/SSH Agent ----------------------------------------------------------

GPG_TTY=$(tty)
export GPG_TTY
if [ -f "${HOME}/.gnupg/gpg-agent-info-$(hostname)" ]; then
    . "${HOME}/.gnupg/gpg-agent-info-$(hostname)"
    export GPG_AGENT_INFO
    #export SSH_AUTH_SOCK
    #export SSH_AGENT_PID
fi

# }}} --------------------------------------------------------------------------
