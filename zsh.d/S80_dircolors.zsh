#!/bin/zsh


# Here the colors for ls
if [[ -f `which dircolors 2>/dev/null` ]]; then
    eval "`dircolors`"
    export LS_COLORS="*.ogm=01;35:${LS_COLORS}"
    alias ls="ls --color=auto"
fi

