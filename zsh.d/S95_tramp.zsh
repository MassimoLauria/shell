#!/bin/zsh

# Emacs Tramp Mode require no fancy stuff 
# in the terminal
if [ $TERM == "dumb" ]
then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  unfunction precmd   2> /dev/null
  unfunction preexec  2> /dev/null
  PS1='$ '
  PROMPT='$ '
  PS2='> '
fi
