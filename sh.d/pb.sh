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
        fzf -e --ansi --reverse -m \
            --preview-window down:6:hidden:wrap --bind '?:toggle-preview' \
            --preview 'echo {} | tr "\t" "\n" '  |
        awk 'BEGIN { FS = "\t" } { print $5 }'  |
        xargs open
}
