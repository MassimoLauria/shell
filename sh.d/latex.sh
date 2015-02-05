#!/bin/sh
#
# Copyright (C) 2014, 2015 by Massimo Lauria
#
# Created   : "2014-10-22, Wednesday 13:06 (CEST) Massimo Lauria"
# Time-stamp: "2015-02-05, 11:48 (CET) Massimo Lauria"
#
# Description::
#
# Shell environmnet variables and functions for LaTeX
# 

# LaTeX enviroment variables

TEXEDIT="$EDITOR +%d %s"

TEXMFHOME="$CONFIGDIR/texmf-public"                      # Public  texmf tree
TEXMFHOME="$TEXMFHOME:$HOME/lavori/latex/texmf-private"  # Private texmf tree

if type sage >/dev/null; then
    # Sage TeX packages
    TEXMFHOME="$TEXMFHOME:`sage -root`/local/share/texmf"
fi

export TEXEDIT
export TEXMFHOME



# Additional paths for LaTeX resources when working on Jakob's papers.
# it requires `function` capabilities from the shell.
[ -n "$BASH" ] || [ -n "$ZSH_NAME" ] || return 0

function jakobtex-enable {
    TEXINPUTS=`kpsewhich --var-value TEXINPUTS`:~/lavori/svnrepos/jakobtex
    BIBINPUTS=`kpsewhich --var-value BIBINPUTS`:~/lavori/svnrepos/jakobtex
    BSTINPUTS=`kpsewhich --var-value BSTINPUTS`:~/lavori/svnrepos/jakobtex
    export TEXINPUTS
    export BIBINPUTS
    export BSTINPUTS
}

function jakobtex-disable {
    unset TEXINPUTS
    unset BIBINPUTS
    unset BSTINPUTS
}
