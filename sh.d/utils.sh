#!/bin/sh

#
# Massimo Lauria setup for cmd line utils
#


# {{{ Pager --------------------------------------------------------------------
if type most >/dev/null 2>&1; then
    PAGER=most
elif type less >/dev/null 2>&1; then
    PAGER=less
else
    PAGER=more
fi
export PAGER
# }}} --------------------------------------------------------------------------

# bat is better than cat, but defaults are funny
if type bat >/dev/null 2>&1; then
    export BAT_PAGER=less
    alias cat=bat
fi
