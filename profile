# -*- mode: sh -*-
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH="$HOME/.elan/bin:$PATH"

## Stuff that it is too slow to run for every terminal

# Latex bibpath
if type kpsepath >/dev/null 2>&1; then
   export TEXINPUTS=$(kpsepath tex):$HOME/lavori/latex
   export BIBINPUTS=$(kpsepath bib):$HOME/lavori/latex
fi

# Pyenv setup
export PYENV_ROOT="$HOME/.pyenv"
if [ -d $PYENV_ROOT ]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -| sed s/precmd/precwd/g)"
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
fi
