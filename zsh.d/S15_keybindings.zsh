#!/bin/zsh

# Some keybindings I fancy in ZSH

# Start with Emacs setting
bindkey -e


# Left-Right arrows with modifiers
bindkey ";5C" forward-word
bindkey ";5D" backward-word
bindkey ";3C" forward-word
bindkey ";3D" backward-word
bindkey ";2C" forward-word
bindkey ";2D" backward-word

# Up-Down arrows with modifiers
bindkey ";5A" beginning-of-line
bindkey ";5B" end-of-line
bindkey ";3A" beginning-of-line
bindkey ";3B" end-of-line
bindkey ";2A" beginning-of-line
bindkey ";2B" end-of-line



########################
#                      #
#    Key settings      #
#                      #
########################

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
# Special keys are implemented with Alt modifier.
# Control-special keys are implemented with Control modifier. 

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

# Arrows on home row
bindkey "^[j" backward-char        # M-j
bindkey "^[l" forward-char         # M-l
bindkey "^[i" up-line-or-history   # M-i
bindkey "^[k" down-line-or-history # M-k

# Home/End on home row
bindkey "^[u" beginning-of-line # M-u
bindkey "^[o" end-of-line       # M-o

# C-Arrows
#"\e[1;5D": backward-word           # C-Left
#"\e[1;5C": forward-word            # C-Right
#"\e[1;5A": history-search-backward # C-Up
#"\e[1;5B": history-search-forward  # C-Down
# 
# 
## C-Home/End
#"\e[1;5H": beginning-of-history    # C-Home
#"\e[1;5F": end-of-history          # C-End
# 
# 
## C-Arrows on home row
##C-j: backward-word
##C-l: forward-word
##C-i: history-search-backward
##C-k: history-search-forward
# 
## C-Home/End
#C-u: beginning-of-history    
#C-o: end-of-history 
# 
# 
###################
## Deletion keys  #
###################
bindkey "^[w" backward-kill-word   #M-w 
bindkey "^[d" backward-delete-char #M-d 
bindkey "^[f" delete-char          #M-f 
bindkey "^d"  backward-kill-word   #C-d 
bindkey "^f"  kill-word            #C-f 

# 
# 
## Backspace, Delete, C-Backspace, C-Delete
# 
# 
###################
## Cut/Paste/Undo #
###################
bindkey "^[x" kill-region  #M-x
bindkey "^x"  kill-region  #C-x

bindkey "^[c" copy-region-as-kill #M-c: 
bindkey "^c"  copy-region-as-kill #C-c: 

bindkey "^[v" yank                #M-v: 
bindkey "^v"  yank                #C-v: 

bindkey "^[z"  undo               #M-z: 
bindkey "^z"   undo               #C-z: 

bindkey "^[\ " set-mark-command   #M-Space
bindkey "^\ "  set-mark-command   #C-Space

bindkey "^[y"  yank-pop           #M-y:
 


