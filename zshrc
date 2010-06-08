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
# }}} --------------------------------------------------------------------------


# Prompt char function. (BROKEN)
function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '$'
}

function find_repo_priority {
    START=$PWD
    while [ $PWD != "/" ]; do
        if [ -d .git ]; then
            echo '±' && return
        elif [ -d .hg ]; then
            echo "☿" && return
        else          
            cd ..
        fi
    done
    
    # 
    echo "$" && return
}


# {{{ Prompt -------------------------------------------------------------------
autoload -U colors && colors
PR_BLUE="%{$fg_bold[blue]%}"
PR_YELLOW="%{$fg_bold[yellow]%}"
PR_RESET="%{$reset_color%}"
PROMPT="$PR_BLUE%1~$PR_RESET$ " # default prompt
RPROMPT="[%n@%m:$PR_BLUE%~$PR_RESET($PR_YELLOW%*$PR_RESET)]" # prompt for right side of screen
# }}} --------------------------------------------------------------------------



