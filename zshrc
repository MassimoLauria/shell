# The following lines were added by compinstall

zstyle ':completion:*' completer _complete
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'm:{a-z}={A-Z}' 'r:|[._-]=** r:|=**'
zstyle :compinstall filename '/home/massimo/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=10000
setopt appendhistory extendedglob nomatch
unsetopt autocd beep
bindkey -e
# End of lines configured by zsh-newuser-install


#### User customization #####

# Common shell environment
source ~/config/shell/shenv-common

# Z-shell script directory
ZSHD=~/config/shell/zsh.d 


# {{{ GnuPG/SSH Agent ----------------------------------------------------------

GPG_TTY=$(tty)
export GPG_TTY
if [ -f "${HOME}/.gnupg/gpg-agent-info-$(hostname)" ]; then
    . "${HOME}/.gnupg/gpg-agent-info-$(hostname)"
    export GPG_AGENT_INFO
    #export SSH_AUTH_SOCK
    #export SSH_AGENT_PID
fi

# }}} --------------------------------------------------------------------------


# {{{ Items --------------------------------------------------------------------

# Keybinding
source $ZSHD/00_keybindings.zsh
source $ZSHD/10_vcs.zsh
# }}} --------------------------------------------------------------------------



# {{{ Prompt -------------------------------------------------------------------
###
# See if we can use colors.
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
done
PR_NO_COLOUR="%{$terminfo[sgr0]%}"
PR_RESET="%{$reset_color%}"


###
# See if we can use extended characters to look nicer.
typeset -A altchar
set -A altchar ${(s..)terminfo[acsc]}
PR_SET_CHARSET="%{$terminfo[enacs]%}"
PR_SHIFT_IN="%{$terminfo[smacs]%}"
PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
PR_HBAR=${altchar[q]:--}
PR_ULCORNER=${altchar[l]:--}
PR_LLCORNER=${altchar[m]:--}
PR_LRCORNER=${altchar[j]:--}
PR_URCORNER=${altchar[k]:--}


d_col='blue'
b_col='yellow'
n_tru='green'
n_fal='red'

setopt prompt_subst

exit_value_prompt='<%(?.%{$fg_bold[$n_tru]%}.%{$fg_bold[$n_fal]%})%?%{$reset_color%}>'
PS2='%_ %{$fg_bold[$d_col]%}→ %{$reset_color%}'

PROMPT=$exit_value_prompt'%{$fg_bold[blue]%}%1~%{$reset_color%}$ ' # default prompt
RPROMPT='[%n@%m:%{$fg_bold[blue]%}%~%{$reset_color%}(%{$fg_bold[yellow]%}%*%{$reset_color%})]' # prompt for right side of screen
# }}} --------------------------------------------------------------------------



