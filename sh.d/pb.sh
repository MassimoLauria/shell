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

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     opencmd=xdg-open;;
    Darwin*)    opencmd=open;;
    *)          opencmd=xdg-open
esac 

function _pb_check_install() {
    local fail=0
    type fzf >/dev/null 2>&1 ||
        { echo >&2 "Required 'fzf' command is missing."; fail=1; }
    python -c 'import pinboard' >/dev/null 2>&1 ||
        { python -m pip install pinboard } ||
        { echo >&2 "Required python module 'pinboard' is missing and can't be installed."; fail=1; }
    return ${fail}
}


function pbcache() {
    _pb_check_install || return 1 
    echo "Fetching pinboard.in bookmarks"
    python "$PINDOWNLOAD" --forcecolors > "$PIN_CACHE_FILE"
}

function pb() {
    _pb_check_install || return 1
    local fzf_opts=
    local open_cmd='xdg-open'
    if [ $(uname) = "Darwin" ]; then
        open_cmd=open
    fi
    cat ${PIN_CACHE_FILE}                       |
        fzf -e -i --ansi --reverse -m \
            --tabstop=4  -d '\t' \
            --prompt='Pin> ' \
            --preview-window down:6:wrap --bind '?:toggle-preview,ctrl-s:toggle-sort' \
            --preview 'echo {1} "--- "{2}"\n\n"{3}"\n\nURL: "{5}'  |
        awk 'BEGIN { FS = "\t" } { print $5 }'  |
        xargs ${opencmd}
}
