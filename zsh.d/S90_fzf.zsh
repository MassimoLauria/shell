#!/bin/zsh
#
# fzf - Fuzzy Finder for the command line
#
# Install via Homebrew on MacOS
# $ brew install fzf
# $ $(brew --prefix)/opt/fzf/install
#
# Install via Git
# $ git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
# $ ~/.fzf/install
#
#

# If ripgrep is installed, use this to search files in fzf
# https://github.com/BurntSushi/ripgrep
#
if type rg >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='rg --files --ignore-file $HOME/config/shell/rg-ignore'
fi


export FZF_DEFAULT_OPTS="--border"

### Files search
export FZF_CTRL_T_OPTS="--prompt 'Files> ' -m  --preview-window hidden --bind '?:toggle-preview' --preview 'bat --style=numbers --color=always {} | head -500'"


### Folder search
export FZF_ALT_C_OPTS="--prompt 'Dir> ' -m --header='Select a folder' --preview 'ls -C {}' --preview-window hidden --bind '?:toggle-preview'"

# Full command on the preview windows
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"



function fzf_exists() {
    if type fzf >/dev/null 2>&1; then
        return 0
    else
        return 1
    fi
}


function fzf_create() {
    # This is for Debian, which does not create .fzf.zsh
    echo "source /usr/share/doc/fzf/examples/key-bindings.zsh" > ~/.fzf.zsh
    echo "source /usr/share/doc/fzf/examples/completion.zsh"   >> ~/.fzf.zsh
}


function fzf_activate() {
    source ~/.fzf.zsh
}

function fzf_zsh_special_keys() {

    # Remove defaults
    bindkey "^t"  undefined-key
    bindkey "\ec" undefined-key

    # Search backward/forward in history
    bindkey "^[b" fzf-history-widget  # M-b
    bindkey "^[n" fzf-history-widget  # M-n

    # "page up" and "page down" to search the history
    bindkey "\e[5~" fzf-history-widget
    bindkey "\e[6~" fzf-history-widget

    # Ctrl-S search forward in history, but it is seldom useful
    bindkey "^s" fzf-history-widget

    # Ctrl-F looks for filenames
    bindkey "^f" fzf-file-widget
    bindkey "^t" undefined-key

}

# All setups for fzf
function fzf_setup() {
    fzf_activate
    fzf_zsh_special_keys
}

if fzf_exists; then
    [ -f ~/.fzf.zsh ] || fzf_create && fzf_setup
fi
