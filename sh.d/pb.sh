#!/bin/sh
#
# Massimo Lauria, 2020
#
# Shell utilities for pinboard.in
#
#
# pb - search in pinboard bookmarks
# pbcache - update local cache
#

#
# Requirements: 
# 
# - pinboard.py python package (https://github.com/lionheart/pinboard.py)
# - fzf         fuzzy finder   (https://github.com/junegunn/fzf)

# Possible options for fzf (color theme)
# --color fg:242,bg:236,hl:65,fg+:15,bg+:239,hl+:108 \
# --color info:108,prompt:109,spinner:108,pointer:168,marker:168 \


PIN_CACHE_FILE=$HOME/.pinboard.cache
PINBOARDRC=$HOME/.pinboardrc
PINDOWNLOAD=${CONFIGDIR}/shell/sh.d/pincache.py




function pbcache() { 
    echo "Fetching pinboard.in bookmarks"
    python "$PINDOWNLOAD" --forcecolors > "$PIN_CACHE_FILE"
}

function pb() {
    local fzf_opts=
    local open_cmd='xdg-open'
    if [ $(uname) = "Darwin" ]; then
        open_cmd=open
    fi
    cat ${PIN_CACHE_FILE}                       |
        fzf -e -i --ansi --reverse -m \
            --tabstop=4  -d '\t' \
            --prompt='Pin> ' \
            --preview-window down:6:wrap --bind '?:toggle-preview' \
            --preview 'echo {1} "--- "{2}"\n\n"{3}"\n\nURL: "{5}'  |
        awk 'BEGIN { FS = "\t" } { print $5 }'  |
        xargs open
}
