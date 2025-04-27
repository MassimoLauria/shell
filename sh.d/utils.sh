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

# 'eza/exa' is a more sophisticated replacement for 'ls'
if type eza >/dev/null 2>&1; then
    alias ls="eza -hg --icons --git"
elif type exa >/dev/null 2>&1; then
    alias ls="exa -hg --icons --git"
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

# 'btop' is graphical version of 'top'
# 'htop' is less intrusive but I want to get used to btop
if type btop >/dev/null 2>&1; then
    alias top="btop"
elif type htop >/dev/null 2>&1; then
    alias top="htop"
fi

# 'fd' is a more modern and usable version of 'find'
# https://github.com/sharkdp/fd
#
# ubuntu has it installed as fdfind
if type fdfind >/dev/null 2>&1; then
    alias fd="fdfind"
fi

# 'b' as an alias for my fzf interface to the firefox bookmarks
if type ${HOME}/config/scripts/search-ff-bookmarks.sh  >/dev/null 2>&1; then
    alias b='${HOME}/config/scripts/search-ff-bookmarks.sh'
fi

# 'd' as an alias for my fzf interface to dictionaries
if type ${HOME}/config/scripts/search-dictionary.sh  >/dev/null 2>&1; then
    alias d='${HOME}/config/scripts/search-dictionary.sh'
fi

# 'bib' as an alias for my fzf interface to bibtex search
if type ${HOME}/config/scripts/search-bibliography.sh  >/dev/null 2>&1; then
    alias bib='${HOME}/config/scripts/search-bibliography.sh'
fi


# Set as one of my wallpaper
function wallpapermk {
    wdir=$HOME/personal/wallpaper
    fname=$(basename "$1")
    echo "Setting $fname as background"
    cp -n $1 ${wdir}/ && \
        ${wdir}/aspectcrop.sh ${wdir}/$fname ${wdir}/aspect169/169_${fname} && \
        feh --no-fehbg --bg-center ${wdir}/aspect169/169_${fname}
}
