#!/bin/sh

# Massimo Lauria, 2025
#
# Source additional sources

[ -f "$HOME/personal/conf/shenv-personal" ] && \
    source $HOME/personal/conf/shenv-personal

[ -f "$HOME/games/shenv" ] && \
    source $HOME/games/shenv
