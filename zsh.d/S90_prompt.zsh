#!/bin/zsh

# references
#   http://www.jukie.net/~bart/blog/tag/zsh
#   http://www.zsh.org/mla/users/2006/msg01196.html
#   http://dotfiles.org/~frogb/.zshrc
#   http://kriener.org/articles/2009/06/04/zsh-prompt-magic


# Load modules
setopt prompt_subst
autoload -Uz vcs_info


# CHECK FOR COLORS -------------------------------------------------------------
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval PR_$color='%{$fg_bold[${(L)color}]%}'
	eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
done
PR_NO_COLOR='%{$terminfo[sgr0]%}'
PR_RESET="%{${reset_color}%}"


# VCS INFO ---------------------------------------------------------------------
# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stagedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
# %s - repository type ----> force git symbol ±
FMT_BRANCH="${PR_WHITE}±${PR_RESET}${PR_GREEN}%b%u%c${PR_RESET}" # e.g. ±master¹²
FMT_ACTION="(${PR_CYAN}%a${PR_RESET}%)"   # e.g. (rebase-i)
FMT_PATH_VCS="${PR_RESET}${PR_BLUE}%R${PR_MAGENTA}/%S"   # e.g. ~/repo/subdir
FMT_PATH_NVCS="${PR_RESET}${PR_BLUE}%~${PR_RESET}"   # e.g. ~/repo/subdir
FMT_UNSTAGE_DIRTY="${PR_RED}¹${PR_RESET}"
FMT_STAGE_DIRTY="${PR_RED}²${PR_RESET}"

FMT_BL=$PR_WHITE'['$PR_RESET
FMT_BR=$PR_WHITE']'$PR_RESET

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*' enable svn hg git bzr
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGE_DIRTY}"  # display ¹ if there are unstaged changes
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGE_DIRTY}"  # display ² if there are staged changes
zstyle ':vcs_info:*:prompt:*' actionformats $FMT_BL"${FMT_BRANCH}${FMT_ACTION}"$FMT_BR "${FMT_PATH_VCS}"
zstyle ':vcs_info:*:prompt:*' formats       $FMT_BL"${FMT_BRANCH}"$FMT_BR              "${FMT_PATH_VCS}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""

# VCS
branch_prompt='$vcs_info_msg_0_'
#
# Next line has a bug and it is commented out. In case we are outside
# of a repository the variable $vcs_info_msg_1_ does not fallback to
# the current working directory, which is a mistake. This hack will
# fix the issue. The correct solution has not been ported to Zsh.
#
# See: https://github.com/zsh-users/zsh/commit/4105f79a3a9b5a85c4ce167865e5ac661be160dc
#
# pwd_prompt='${${vcs_info_msg_1_%%.}/${HOME}/~}' # - Original - M.L.
#
pwd_prompt='${${${vcs_info_msg_1_%%.}:-${PR_RESET}${PR_BLUE}$PWD${PR_RESET}}/${HOME}/~}'     # my fix - M.L.
pwd_prompt_truncated="%B%32<..<${pwd_prompt}%<<%b"

function zsh_vcs_prompt_precmd {
    vcs_info 'prompt'
}
precmd_functions+='zsh_vcs_prompt_precmd'


# PROMPT COMPONENTS -------------------------------------------------------------

date_text=""
date_exit_prompt='%(?.'$PR_GREEN'.'$PR_RED')${date_text}'$PR_RESET

prompt_char='➤'
prompt_char_prompt='%(?.'$PR_NO_COLOR'.'$PR_RED')${prompt_char}'$PR_RESET

dir_prompt=$PR_BLUE'%1~'$PR_RESET


# UPDATER -----------------------------------------------------------------------
export VIRTUAL_ENV_DISABLE_PROMPT=1
function zsh_venv_precmd {
    if [ "${VIRTUAL_ENV}" = "" ]; then
        pyenv_prompt=""
    else
        pyenv_prompt=$FMT_BL$PR_YELLOW''$PR_RESET':'$PR_GREEN'${$(basename $VIRTUAL_ENV)}'$PR_RESET$FMT_BR
    fi
}
precmd_functions+='zsh_venv_precmd'

function zsh_update-date_precmd {
    date_text=`date +%H:%M`
}
precmd_functions+='zsh_update-date_precmd'


function zsh_rprompt_precmd {
    RPROMPT=$pyenv_prompt$branch_prompt
}
precmd_functions+='zsh_rprompt_precmd'


# THE PROMPT -----------------------------------------------------------------

case $TERM in
    xterm*|rxvt*|screen*|eterm*)

        PROMPT_EOL_MARK=$PR_RED'<NOEOL>'$PR_RESET

        PS2=$PR_WHITE'    %_ '$PR_RESET$PR_BLUE'→ '$PR_RESET

        PROMPT=$PR_WHITE'('$PR_RESET$pwd_prompt_truncated$PR_WHITE')'$PR_RESET'
'$date_exit_prompt$prompt_char_prompt' '
        ;;

    dumb) # Simple prompt for dumb terminals
        unsetopt zle
        PROMPT='%n@%m:%~$ '
        ;;
    *)
        PROMPT='%n@%m:%~$ '
        PS2='> '
        ;;
esac
