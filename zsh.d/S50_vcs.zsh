#!/bin/zsh

# Utility functions for VCS (e.g. GIT, mercurial, SVN, ...)
# information in prompt.


# This variable dictates weather we are going to do the vcs prompt update
# before printing the next prompt.  On some setups this saves 10s of work.
__VCS_REPO_UPDATE=1

# called before command excution
# here we decide if we should update the prompt next time
function zsh_vcs_prompt_preexec {
        case "$(history $HISTCMD)" in 
            *git*|*hg*|*svn*)
                __VCS_REPO_UPDATE=1
                ;;
        esac
}
preexec_functions+='zsh_vcs_prompt_preexec'

# called after directory change
# we just assume that we have to update vcs prompt
function zsh_vcs_prompt_chpwd {
     __VCS_REPO_UPDATE=1
}
chpwd_functions+='zsh_vcs_prompt_chpwd'

# called before prompt generation
# if needed, we will update the prompt info
function zsh_vcs_prompt_precmd {
       if [[ -n "$__VCS_REPO_UPDATE" ]] ; then
               vcs_info 'prompt'
               __VCS_REPO_UPDATE=
       fi
}
precmd_functions+='zsh_vcs_prompt_precmd'



