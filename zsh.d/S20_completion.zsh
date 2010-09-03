#!/bin/zsh

# Completion setting


autoload -Uz compinit

if [ $UID -ne 0 ]; then
    compinit -d $zsh_cache/zcomp-$HOST
else
    compinit
fi


# Completion customization
zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**'
zstyle :compinstall filename $zshrc_path

#zstyle ':completion:*' add-space true
#zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list
zstyle ':completion:*' menu select=1
zstyle ':completion:*' file-sort name
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' matcher-list 'r:|[._-]=** r:|=**' 'l:|=** r:|=**'
#zstyle ':completion:*' menu select
#zstyle ':completion:*:approximate:*' max-errors 'reply=( $(( ($#PREFIX+$#SUFFIX)/3 )) numeric )'

#[ Formats ]####################################################################
zstyle ':completion:*' group 1
zstyle ':completion:*' format '%B---- %d%b'
zstyle ':completion:*:corrections' format '%B---- %d (errors %e)%b'
zstyle ':completion:*:descriptions' format "%B---- %d%b"
zstyle ':completion:*:messages' format '%B%U---- %d%u%b' 
zstyle ':completion:*:warnings' format "%B$fg[red]%}---- no match for: $fg[white]%d%b"
zstyle ':completion:*' group-name ''

#[ Kill ]#######################################################################
zstyle ':completion:*:processes' command 'ps -au$USER -o pid,time,cmd|grep -v "ps -au$USER -o pid,time,cmd"'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)[ 0-9:]#([^ ]#)*=01;30=01;31=01;38'

#[ hosts and users ]############################################################
#hosts=()
#[ -r ~/.ssh/config ] && hosts=(${${${$(grep '^Host' ~/.ssh/config)}##Host }##[*0-9]*})
#[ -r ~/.ssh/known_hosts ] && hosts=(${${${${(f)"$(<$HOME/.ssh/known_hosts)"}:#[0-9]*}%\*}%,*})
#hosts=($( ( \
#        ( [ -r ~/.ssh/config ] && awk '/^host +[a-z]/ { print $2 }' ~/.ssh/config) ; \
#        ( [ -r ~/.ssh/known_hosts ] && awk '{print $1}' ~/.ssh/known_hosts | tr , '\n') \
#) | sort -u))
# 
#zstyle ':completion:*' hosts $hosts
#zstyle ':completion:*:hosts' list-colors '=(#b)(*)(.jukie.net)=01;30=01;31' '=[^.]#=01;31'
# 
#users=(root bart bartman)
#zstyle ':completion:*' users $users


#[ OSX Application awareness ]##################################################
if [ "`uname`" = "Darwin" ]; then
   compctl -f -x 'p[2]' -s "`/bin/ls -d1 /Applications/*/*.app
/Applications/*.app | sed 's|^.*/\([^/]*\)\.app.*|\\1|;s/ /\\\\ /g'`" -- open
#   alias run='open -a'
fi 2> /dev/null


#[ Applications and viewer ]####################################################

zstyle ':completion:*:*:[akx]dvi:*' file-patterns \
    '*.dvi:dvi-files:DVI\ files *(-/):directories:Directories' '*:all-files'

zstyle ':completion:*:*:evince:*' file-patterns \
    '*.(ps|pdf|djvu|dvi)(|.gz|.bz2):evince-files:Document\ files  *(-/):directories:Directories' '*:all-files'

zstyle ':completion:*:*:xpdf:*' file-patterns \
    '*.pdf:pdf-files:PDF\ documents  *(-/):directories:Directories' '*:all-files'

zstyle ':completion:*:*:(g|)gv:*' file-patterns \
    '*.ps(|.gz):ps-files:Postscript\ documents  *(-/):directories:Directories' '*:all-files'

zstyle ':completion:*:*:djview(4|):*' file-patterns \
    '*.djvu:djvu-files:Deja\ View\ documents  *(-/):directories:Directories' '*:all-files'

zstyle ':completion:*' file-patterns \
    '%p:globbed-files: *(-/):directories:Directories' '*:all-files'

#[ ignores for editors ]############################################################

zstyle ':completion:*:*:ec(x|):*:*files' ignored-patterns '*?.(aux|dvi|ps|pdf|bbl|brf|blg|toc|lot|lof|o|cm?)'
zstyle ':completion:*:*:emacs:*:*files' ignored-patterns  '*?.(aux|dvi|ps|pdf|bbl|brf|blg|toc|lot|lof|o|cm?)'
zstyle ':completion:*:*:vi(m|):*:*files' ignored-patterns '*?.(aux|dvi|ps|pdf|bbl|brf|blg|toc|lot|lof|o|cm?)'
