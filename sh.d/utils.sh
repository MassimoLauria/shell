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
#
# In ubuntu it is installed as batcat
if type bat >/dev/null 2>&1; then
    export BAT_PAGER=less
    alias cat=bat
elif type batcat >/dev/null 2>&1; then
    export BAT_PAGER=less
    alias cat=batcat
fi

# 'exa' is a more sophisticated replacement for 'ls'
# https://the.exa.website/
if type exa >/dev/null 2>&1; then
    alias ls="exa -hg --git"
else
    alias ls="ls --color=auto"
fi

# 'duf' is a more sophisticated replacement for 'df'
# https://github.com/muesli/duf
if type duf >/dev/null 2>&1; then
    alias df="duf"
fi

# 'dust' is a more sophisticated replacement for 'du'
# https://github.com/bootandy/dust
if type dust >/dev/null 2>&1; then
    alias du="dust"
fi

# 'gping' is graphical version of 'ping'
# https://github.com/orf/gping
if type gping >/dev/null 2>&1; then
    alias ping="gping"
fi

# 'bashtop' is graphical version of 'top'
# 'htop' is less intrusive but I want to get used to bashtop
# https://github.com/aristocratos/bashtop
if type bashtop >/dev/null 2>&1; then
    alias top="bashtop"
fi


# 'fd' is a more modern and usable version of 'find'
# https://github.com/sharkdp/fd
#
# ubuntu has it installed as fdfind
if type fdfind >/dev/null 2>&1; then
    alias fd="fdfind"
fi




function covid {
    local args
    if [ $# -eq 0 ]; then
        args=it
    elif [ $# -eq 1 ]; then
        args=$1
    else
        echo "Usage: covid <countrycode>"; return 1
    fi
    curl -L covid19.trackercli.com/history/$args
}

function uskey {
    setxkbmap -option
    python ~/config/xsession/xkb_capsunlock.py
    setxkbmap -config ~/config/xsession/setxkbmap.pcus
}

function resetkey {
    setxkbmap -option
}
