#!/bin/sh

#
# Setup for command line tools:
#
# There are very neat and powerful tools that extends the usual
# command line utilities. I will set them up, when present.
#

#
# PAGER setup. I prefer http://www.jedsoft.org/most/
#
if type most >/dev/null 2>&1; then
    PAGER=most
elif type less >/dev/null 2>&1; then
    PAGER=less
else
    PAGER=more
fi
export PAGER


# 'bat' is good for showing files
# so I use it instead of 'cat'
# https://github.com/sharkdp/bat
if type bat >/dev/null 2>&1; then
    export BAT_PAGER=less
    alias cat=bat
fi

# 'exa' is a more sophisticated replacement for 'ls'
# https://the.exa.website/
if type exa >/dev/null 2>&1; then
    alias ls="exa -hg --git --git-ignore"
fi


