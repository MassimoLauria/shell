#!/bin/zsh

#
# This Massimo Lauria Z-Shell rc init file.
#
# Much of this file is based on code stolen here and there, 
# most from Bart Trojanowski and Phil!
#

# --- Files and paths -----------------------------------------------------------------

config_path=${HOME}/config/shell/

zshrc_path=${HOME}/.zshrc

zsh_sources=${config_path}/zsh.d 
zsh_cache=${HOME}/.zsh/cache
zsh_histfile=$zsh_cache/history

mkdir -p $zsh_cache

# --- Recompiling ---------------------------------------------------------------------

autoload -U zrecompile

if [ $UID -ne 0 ]; then

        for f in $zshrc_path $zsh_cache/zcomp-$HOST; do
                zrecompile -p $f && rm -f $f.zwc.old
        done
fi

# {{{ Z-shell scripts -----------------------------------------------------------------

# Common
source ${config_path}/shenv-common

# Z-Shell
setopt extended_glob
for zsh_snipplet in $zsh_sources/S[0-9][0-9]*[^~] ; do
        source $zsh_snipplet
done


# }}} ---------------------------------------------------------------------------------




