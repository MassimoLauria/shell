#!/bin/zsh

# Some keybindings I fancy in ZSH

# Use Emacs style bindings
bindkey -e

# Left-Right arrows with modifiers
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
bindkey "^[[1;2C" forward-word
bindkey "^[[1;2D" backward-word

# Up-Down arrows with modifiers
bindkey "^[[1;5A" beginning-of-line
bindkey "^[[1;5B" end-of-line
bindkey "^[[1;3A" beginning-of-line
bindkey "^[[1;3B" end-of-line
bindkey "^[[1;2A" beginning-of-line
bindkey "^[[1;2B" end-of-line

# "page up" and "page down" to search the history
bindkey "\e[5~" history-search-backward
bindkey "\e[6~" history-search-forward

# Arrows (default setting)
bindkey "\e[D" backward-char         # Left
bindkey "\e[C" forward-char          # Right
bindkey "\e[A" up-line-or-history    # Up
bindkey "\e[B" down-line-or-history  # Down

# Home/End
bindkey "\e[H" beginning-of-line # Home
bindkey "\e[F" end-of-line       # End


######################################
#                                    #
#   Basic Keyboard Key settings      #
#                                    #
######################################

# Rationale
#
# j = Left
# l = Right
# i = Up
# k = Down
#
# u = Home
# o = End
#
# b = Prev
# n = Next


# Arrows on home row
bindkey "^[j" backward-char        # M-j
bindkey "^[l" forward-char         # M-l
bindkey "^[i" up-line-or-history   # M-i
bindkey "^[k" down-line-or-history # M-k

# Word jumps above home row
bindkey "^[u" backward-word        # M-u
bindkey "^[o" forward-word         # M-o

# Home/End on home row
bindkey "^[g" beginning-of-line # M-g
bindkey "^[h" end-of-line       # M-h

# Search backward/forward in history
bindkey "^[b" history-search-backward # M-b
bindkey "^[n" history-search-forward  # M-n


###################
#  Deletion keys  #
###################

bindkey "^[e" backward-kill-word    #M-e
bindkey "^[r" kill-word             #M-r
bindkey "^[d" backward-delete-char  #M-d
bindkey "^[f" delete-char           #M-f
bindkey "^[w" kill-whole-line       #M-w
#bindkey "^d"  backward-kill-word   #C-d
#bindkey "^f"  kill-word            #C-f

###################
#  Cut/Paste/Undo #
###################
bindkey "^x"   kill-region         #C-x
bindkey "^c"   copy-region-as-kill #C-c
bindkey "^v"   yank                #C-v
bindkey "^z"   undo                #C-z
bindkey "^[\ " set-mark-command    #M-Space (differ from my Emacs bindings)
bindkey "^\ "  set-mark-command    #C-Space
bindkey "^[y"  yank-pop            #M-y



######################################
#                                    #
#      Command Line editing          #
#                                    #
######################################
autoload edit-command-line
zle -N edit-command-line
bindkey "^e" edit-command-line  # C-e

