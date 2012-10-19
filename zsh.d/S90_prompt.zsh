#!/bin/zsh

# references
#   http://www.jukie.net/~bart/blog/tag/zsh
#   http://www.zsh.org/mla/users/2006/msg01196.html
#   http://dotfiles.org/~frogb/.zshrc
#   http://kriener.org/articles/2009/06/04/zsh-prompt-magic


# Load modules
setopt prompt_subst
autoload -Uz vcs_info


# {{{ CHECK FOR COLORS ---------------------------------------------------------
autoload colors zsh/terminfo
if [[ "$terminfo[colors]" -ge 8 ]]; then
colors
fi
for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	eval PR_$color='%{$fg_bold[${(L)color}]%}'
	eval PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	(( count = $count + 1 ))
done
PR_NO_COLOUR='%{$terminfo[sgr0]%}'
PR_RESET='%{$reset_color%}'
# }}} --------------------------------------------------------------------------

# {{{ COLOR THEMES -------------------------------------------------------------
### Theme with more than 8 colors
PR_PROMPT_CHAR_COLOR=$PR_NO_COLOUR

PR_PATH_COLOR=$PR_BLUE
PR_REPO_PATH_COLOR=$PR_BLUE
PR_REPO_SUBDIR_COLOR=$PR_MAGENTA

PR_TIME_COLOR=$PR_GREEN

PR_USERNAME_COLOR=$PR_NO_COLOUR
PR_HOSTNAME_COLOR=$PR_NO_COLOUR
PR_TTY_COLOR=$PR_NO_COLOUR

PR_EXITVALUE_T_COLOR=$PR_GREEN
PR_EXITVALUE_F_COLOR=$PR_RED

PR_PARSER_DATA_COLOR=$PR_WHITE
PR_PARSER_PROMPT_COLOR=$PR_BLUE

PR_VCS_TYPE_COLOR=$PR_WHITE
PR_VCS_ACTION_COLOR=$PR_CYAN
PR_VCS_BRANCH_COLOR=$PR_GREEN
PR_VCS_DIRTY_COLOR=$PR_RED

PR_BARL_COLOR=$PR_BLUE
PR_BARS_COLOR=$PR_WHITE

# Themes modification for root
if [ $UID -eq 0 ]; then
    PR_BARL_COLOR=$PR_RED
    PR_BARS_COLOR=$PR_MAGENTA
fi



# }}} --------------------------------------------------------------------------

# {{{ CHECK FOR ANSI ART -------------------------------------------------------
# See if we can use extended characters to look nicer.

case $TERM in
    xterm*|rxvt*)

        if [[ $TERM_PROGRAM != "Apple_Terminal" ]]; then
            typeset -A altchar
        fi
        set -A altchar ${(s..)terminfo[acsc]}
        PR_SET_CHARSET="%{$terminfo[enacs]%}"
        PR_SHIFT_IN="%{$terminfo[smacs]%}"
        PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
        PR_HBAR=${altchar[q]:-'-'}
        PR_VBAR=${altchar[x]:-'|'}
        PR_ULCORNER=${altchar[l]:-'/'}
        PR_LLCORNER=${altchar[m]:-'\'}
        PR_LRCORNER=${altchar[j]:-'/'}
        PR_URCORNER=${altchar[k]:-'\'}
        ;;
    *)
        PR_SET_CHARSET=""
        PR_SHIFT_IN=""
        PR_SHIFT_OUT=""
        PR_HBAR='-'
        PR_VBAR='|'
        PR_ULCORNER='/'
        PR_LLCORNER='\'
        PR_LRCORNER='/'
        PR_URCORNER='\'
        ;;
esac


# }}} --------------------------------------------------------------------------


# {{{ VCS INFO -----------------------------------------------------------------
# set formats
# %b - branchname
# %u - unstagedstr (see below)
# %c - stangedstr (see below)
# %a - action (e.g. rebase-i)
# %R - repository path
# %S - path in the repository
PR_RST="%{${reset_color}%}"
FMT_BRANCH="${PR_VCS_TYPE_COLOR}%s${PR_RST}:${PR_VCS_BRANCH_COLOR}%b%u%c${PR_RST}" # e.g. master¹²
FMT_ACTION="(${PR_VCS_ACTION_COLOR}%a${PR_RST}%)"   # e.g. (rebase-i)
FMT_PATH_VCS="${PR_RST}${PR_REPO_PATH_COLOR}%R${PR_REPO_SUBDIR_COLOR}/%S"   # e.g. ~/repo/subdir
FMT_PATH_NVCS="${PR_RST}${PR_PATH_COLOR}%~${PR_RST}"   # e.g. ~/repo/subdir
FMT_UNSTAGE_DIRTY="${PR_VCS_DIRTY_COLOR}¹${PR_RST}"
FMT_STAGE_DIRTY="${PR_VCS_DIRTY_COLOR}²${PR_RST}"

FMT_BL=$PR_BARS_COLOR$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT'['$PR_RST
FMT_BR=$PR_BARS_COLOR']'$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$PR_RST

# check-for-changes can be really slow.
# you should disable it, if you work with large repositories
zstyle ':vcs_info:*' enable svn hg git bzr
zstyle ':vcs_info:*:prompt:*' check-for-changes true
zstyle ':vcs_info:*:prompt:*' unstagedstr   "${FMT_UNSTAGE_DIRTY}"  # display ¹ if there are unstaged changes
zstyle ':vcs_info:*:prompt:*' stagedstr     "${FMT_STAGE_DIRTY}"  # display ² if there are staged changes
zstyle ':vcs_info:*:prompt:*' actionformats $FMT_BL"${FMT_BRANCH}${FMT_ACTION}"$FMT_BR "${FMT_PATH_VCS}"
zstyle ':vcs_info:*:prompt:*' formats       $FMT_BL"${FMT_BRANCH}"$FMT_BR              "${FMT_PATH_VCS}"
zstyle ':vcs_info:*:prompt:*' nvcsformats   ""                                         "${FMT_PATH_NVCS}"
# }}} ---------------------------------------------------------------------------


# {{{ PROMPT THEMED COMPONENTS -------------------------------------------------
# Common
exit_value=""
exit_value_prompt='%(?.'$PR_EXITVALUE_T_COLOR'.'$PR_EXITVALUE_F_COLOR')%?'$PR_RESET
userhost_prompt=$PR_USERNAME_COLOR'%n'$PR_RESET'@'$PR_HOSTNAME_COLOR'%m'$PR_RESET':'$PR_TTY_COLOR'%l'$PR_RESET
date_text=""
time_prompt=$PR_TIME_COLOR'${date_text}'$PR_RESET
#pwd_prompt=$PR_PATH_COLOR'%~'$PR_RESET
dir_prompt=$PR_PATH_COLOR'%1~'$PR_RESET

prompt_char='$'
prompt_char_prompt=$PR_PROMPT_CHAR_COLOR'${prompt_char}'$PR_RESET

prompt_mid_filler=""
prompt_top_filler=""

# VCS
branch_prompt='$vcs_info_msg_0_'
pwd_prompt='${${vcs_info_msg_1_%%.}/$HOME/~}'
pwd_prompt_truncated="%B%40<..<${pwd_prompt}%<<%b"
# }}} --------------------------------------------------------------------------


function zsh_vcs_promptchar_precmd {
    case $vcs_info_msg_0_ in
	    *git*)
            prompt_char='±'
            ;;
        *svn*)
            prompt_char='S'
            ;;
        *hg*)
            prompt_char='☿'
            ;;
        *p4*)
            prompt_char='4'
            ;;
        *)
            prompt_char='$'
            ;;
    esac
}
precmd_functions+='zsh_vcs_promptchar_precmd'


function zsh_update-date_precmd {
    date_text=`date +%H:%M`
}
precmd_functions+='zsh_update-date_precmd'

# BROKEN
function zsh_update_top_filler {

    exit_value="$?"
    branch_prompt=""

    local tl=${#${date_text}}
    local el=${#${exit_value}}
    local bl=${#${branch_prompt}} # broken
    local pl=${#${----()----<>-----() }}

    local data_size=0
    ((data_size=$pl+$tl+$bl+$el))
    echo $data_size
    echo $bl
    echo $el
    echo $tl
    echo $pl

    local pwd_size=${#${pwd_prompt}}
    echo $pwd_size

    if [[ "$data_size + $pwd_size" -gt $COLUMNS ]]; then
	    ((pwd_size=$COLUMNS - $data_size))
        prompt_top_filler=""
        # pwd_prompt_truncated="%B%40<..<${pwd_prompt}%<<%b"
    else
        prompt_top_filler="${(l.(($COLUMNS- $data_size - $pwd_size))..X.)}"
        # pwd_prompt_truncated='${pwd_prompt}'
    fi

    pwd_prompt_truncated="%B${pwd_size}<..<${pwd_prompt}%<<%b"
    echo $pwd_size

}
#precmd_functions+='zsh_update_top_filler'


function zsh_update_mid_filler {
    prompt_mid_filler="${(l.(($COLUMNS-3)).. .)}"
}
precmd_functions+='zsh_update_mid_filler'



# {{{ FINALLY, THE PROMPTS -----------------------------------------------------

case $TERM in
    xterm*|rxvt*|screen*)

        # The big one
        PS2=$PR_PARSER_DATA_COLOR'    %_ '$PR_RESET$PR_PARSER_PROMPT_COLOR'→ '$PR_RESET

        PROMPT='
'\
$PR_SHIFT_IN$PR_BARL_COLOR$PR_ULCORNER$PR_HBAR$PR_HBAR\
$PR_BARS_COLOR$PR_HBAR$PR_SHIFT_OUT'('$PR_RESET\
$time_prompt\
$PR_BARS_COLOR')'$PR_SHIFT_IN$PR_HBAR$PR_RESET\
$PR_BARL_COLOR$PR_HBAR$PR_HBAR\
$PR_BARS_COLOR$PR_HBAR$PR_SHIFT_OUT'<'$PR_RESET\
$exit_value_prompt\
$PR_BARS_COLOR'>'$PR_SHIFT_IN$PR_HBAR$PR_RESET\
$PR_BARL_COLOR$PR_HBAR$PR_SHIFT_OUT$PR_RESET\
$branch_prompt\
$PR_BARL_COLOR$PR_SHIFT_IN$PR_HBAR$PR_HBAR$PR_SHIFT_OUT\
$PR_BARS_COLOR$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT'('$PR_RESET\
$pwd_prompt_truncated\
$PR_BARS_COLOR')'$PR_RESET$PR_BARS_COLOR$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$PR_RESET\
'${prompt_top_filler}'\
$PR_SHIFT_IN$PR_BARL_COLOR$PR_HBAR$PR_HBAR$PR_URCORNER$PR_SHIFT_OUT$PR_RESET\
'
'$PR_BARL_COLOR$PR_SHIFT_IN$PR_VBAR$PR_SHIFT_OUT$PR_RESET\
'${prompt_mid_filler}'\
$PR_BARL_COLOR$PR_SHIFT_IN$PR_VBAR$PR_SHIFT_OUT$PR_RESET'
'\
$PR_SHIFT_IN$PR_BARL_COLOR$PR_LLCORNER$PR_HBAR$PR_SHIFT_OUT$PR_RESET\
$prompt_char_prompt' '

        RPROMPT=$PR_BARS_COLOR'<'$PR_RESET\
$userhost_prompt\
$PR_BARS_COLOR'>'$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$PR_RESET\
$PR_BARL_COLOR$PR_SHIFT_IN$PR_HBAR$PR_LRCORNER$PR_SHIFT_OUT$PR_RESET # prompt for right side of screen
        ;;

    eterm*)
        PROMPT=$PR_PATH_COLOR'%~'$PR_RESET'$ '
        RPROMPT='['$exit_value_prompt']'$branch_prompt'('$time_prompt')' # prompt for right side of screen
        PS2='> '
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
