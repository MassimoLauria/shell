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



# Global variables
vcs_prompt_char=''
vcs_branchname=''
vcs_status=''
vcs_action=''
vcs_repo_path=''
vcs_repo_subdir=''
vcs_inside_repo=''

function vcs_find_repository {
    
    local START=$PWD
    
    local INSIDE_GIT=0           # ±
    local INSIDE_MERCURIAL=0     # ☿
    local INSIDE_SVN=0           # S

    local STRING_GIT="±"
    local STRING_MERCURIAL="☿"
    local STRING_SVN="S"           

    
    local REPOS=0
    local OUTPUT=""
    
    # Test Git
    git branch >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
       INSIDE_GIT=1
       (( REPOS = ${REPOS} + 1 ))
    fi

    # Test SVN
    svn info >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
       INSIDE_SVN=1
       (( REPOS = ${REPOS} + 1 ))
    fi

    # Test Mercurial
    hg root >/dev/null 2>/dev/null
    if [ $? -eq 0 ]; then
       INSIDE_MERCURIAL=1
       (( REPOS = ${REPOS} + 1 ))
    fi
    

    # If a repository tree is inside the working tree of another repository of 
    # different type, my test won't notice this. 
    # In such case it looks for the most nested repository.
    while [ $PWD != "/" ]; do

        # Test for Git folder
        if [ $INSIDE_GIT -eq 1 -a -d .git ]; then
            OUTPUT=$STRING_GIT
            break

        # Test for Mercurial folder
        elif [ $INSIDE_MERCURIAL -eq 1 -a -d .hg ]; then
            OUTPUT=$STRING_MERCURIAL
            break

        # Test for Subversion folder
        elif [ $INSIDE_SVN -eq 1 -a -d .hg ]; then
            OUTPUT=$STRING_SVN
            break
        else          
            cd ..
        fi
    done
    
    cd $START
    echo $OUTPUT
}

