# -*- mode: sh -*-
# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

## Stuff that it is too slow to run for every terminal

# Latex bibpath
if type kpsepath >/dev/null 2>&1; then
   export TEXINPUTS=$(kpsepath tex):$HOME/lavori/latex
   export BIBINPUTS=$(kpsepath bib):$HOME/lavori/latex
fi
