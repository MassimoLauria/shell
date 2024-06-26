#!/bin/sh
#
# Copyright (C) 2014, 2015, 2017, 2020, 2023, 2024 by Massimo Lauria
#
# Created   : "2014-10-22, Wednesday 13:06 (CEST) Massimo Lauria"
# Time-stamp: "2024-06-26, 22:30 (CEST) Massimo Lauria"
#
# Description::
#
# Shell environmnet variables and functions for LaTeX
#

# LaTeX enviroment variables
TEXEDIT="$EDITOR +%d %s"
TEXMFHOME="$HOME/lavori/latex:"  # Private texmf tree

export TEXINPUTS=$(kpsepath tex):$HOME/lavori/latex
export BIBINPUTS=$(kpsepath bib):$HOME/lavori/latex

export TEXEDIT
export TEXMFHOME
