#!/bin/sh
#
# Copyright (C) 2011 by Massimo Lauria
#
# Created   : "2011-11-17, Thursday 20:43 (CET) Massimo Lauria"
# Time-stamp: "2011-11-17, Thursday 20:45 (CET) Massimo Lauria"
#
# Description::
#
# Some commands in ZSH requires specific aliases, especially to
# inhibit globbing of patterns.
#

# Code::

# Asterisks in scp commands would be globbed by zsh, which is VERY
# annoying.
alias scp="noglob scp"

# Local Variables:
# fill-column: 80
# End:
