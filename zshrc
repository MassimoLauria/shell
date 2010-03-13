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

source ~/config/shell/shenv-common



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


bindkey ";5C" forward-word
bindkey ";5D" backward-word
bindkey ";3C" forward-word
bindkey ";3D" backward-word
bindkey ";2C" forward-word
bindkey ";2D" backward-word

bindkey ";5A" beginning-of-line
bindkey ";5B" end-of-line
bindkey ";3A" beginning-of-line
bindkey ";3B" end-of-line
bindkey ";2A" beginning-of-line
bindkey ";2B" end-of-line


# }}} --------------------------------------------------------------------------



# {{{ Prompt -------------------------------------------------------------------

PROMPT='%n@%m:%~$ ' # default prompt
RPROMPT='[%* on %D]' # prompt for right side of screen

# }}} --------------------------------------------------------------------------



