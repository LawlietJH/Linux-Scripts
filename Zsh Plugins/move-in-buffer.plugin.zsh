# Move in buffer:

bindkey '^H'       backward-kill-word   # Ctrl + Backspace	Delete the word on the left
bindkey '\e[3;5~'  kill-word            # Ctrl + Del		Delete the word on the right
bindkey '^[[1;5D'  backward-word        # Ctrl + LeftArrow	Jump to the beginning of the word on the left
bindkey '^[[1;5C'  forward-word         # Ctrl + RightArrow	Jump to the end of the word on the right
bindkey '^[[H'     beginning-of-line    # Home			Jump to the beginning of the buffer
bindkey '^[[F'     end-of-line          # End			Jump to the end of the buffer
