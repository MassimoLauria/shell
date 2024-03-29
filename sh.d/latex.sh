#!/bin/sh
#
# Copyright (C) 2014, 2015, 2017, 2020, 2023 by Massimo Lauria
#
# Created   : "2014-10-22, Wednesday 13:06 (CEST) Massimo Lauria"
# Time-stamp: "2023-05-21, 19:33 (CEST) Massimo Lauria"
#
# Description::
#
# Shell environmnet variables and functions for LaTeX
#

# LaTeX enviroment variables

TEXEDIT="$EDITOR +%d %s"

TEXMFHOME="$HOME/lavori/latex:"  # Private texmf tree

if type sage >/dev/null 2>&1; then
    # Sage TeX packages
    TEXMFHOME="`sage -root`/local/share/texmf:$TEXMFHOME"
fi

export TEXEDIT
export TEXMFHOME



# Additional paths for LaTeX resources when working on Jakob's papers.
# it requires `function` capabilities from the shell.
[ -n "$BASH" ] || [ -n "$ZSH_NAME" ] || return 0



function jakobtex-enable {
    local aPath=$HOME/lavori/latex/jakobtex
    TEXINPUTS=$aPath:`kpsewhich --var-value TEXINPUTS`
    BIBINPUTS=$aPath:`kpsewhich --var-value BIBINPUTS`
    BSTINPUTS=$aPath:`kpsewhich --var-value BSTINPUTS`
    export TEXINPUTS
    export BIBINPUTS
    export BSTINPUTS
}

function jakobtex-disable {
    unset TEXINPUTS
    unset BIBINPUTS
    unset BSTINPUTS
}
