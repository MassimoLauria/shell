#!/bin/zsh

# Utility functions for VCS (e.g. GIT, mercurial, SVN, ...)
# information in prompt.


# Global variables
vcs_prompt=''
vcs_branchname=''
vcs_status=''
vcs_color_1=''
vcs_color_2=''

function vcs_decide_repo {
    
    local START=$PWD
    
    local INSIDE_GIT=0           # ±
    local INSIDE_MERCURIAL=0     # ☿
    local INSIDE_SVN=0           # S

    local STRING_GIT="git(±)"
    local STRING_MERCURIAL="mercurial(☿)"
    local STRING_SVN="svn(S)"           

    
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

