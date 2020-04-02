#!/bin/sh
#
# Massimo Lauria, 2020
#
# Shell utilities for dictionaries
#
#
# d - interactively search for a word in the dictionary
#

#
# Requirements:
#
# - fzf         fuzzy finder   (https://github.com/junegunn/fzf)
# - sdcv        StarDict Console Version

WORDFILE=$HOME/personal/dictionaries/wordlists/english_and_italian.txt

    
function d() {
    local args=""
    local query=""

    if [ "$#" -ge 1 ]; then
        query="-q"
        args=$@
    fi

    cat $WORDFILE |
    fzf -i --print0 --reverse \
        $query $args \
        --prompt "Cerca: " \
        --preview "sdcv -enc0 {}" \
        --preview-window wrap  --bind '?:toggle-preview' | xargs -0 -n 1 sdcv -enc0  
}
