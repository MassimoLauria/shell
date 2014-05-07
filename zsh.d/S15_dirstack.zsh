#!/bin/zsh
#
# Copyright (C) 2014 by Massimo Lauria
#
# Created   : "2014-05-07, Wednesday 09:31 (CEST) Massimo Lauria"
# Time-stamp: "2014-05-07, 09:37 (CEST) Massimo Lauria"
#
# Description::
#
# Persistent dirstack history across sessions.
#

# Code::

DIRSTACKSIZE=9
DIRSTACKFILE=~/.zdirs
if [[ -f $DIRSTACKFILE ]] && [[ $#dirstack -eq 0 ]]; then
  dirstack=( ${(f)"$(< $DIRSTACKFILE)"} )
  [[ -d $dirstack[1] ]] && cd $dirstack[1] && cd $OLDPWD
fi
chpwd() {
  print -l $PWD ${(u)dirstack} >$DIRSTACKFILE
}

# Local Variables:
# fill-column: 80
# End:
