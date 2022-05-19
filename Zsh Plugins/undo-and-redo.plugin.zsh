# Undo text in the Buffer:
bindkey -M emacs '^[[1;7D' undo		# Ctrl + Alt + LeftArrow
bindkey -M viins '^[[1;7D' undo		# Ctrl + Alt + LeftArrow
bindkey -M vicmd '^[[1;7D' undo		# Ctrl + Alt + LeftArrow

# Redo text in the Buffer:
bindkey -M emacs '^[[1;7C' redo		# Ctrl + Alt + RightArrow
bindkey -M viins '^[[1;7C' redo		# Ctrl + Alt + RightArrow
bindkey -M vicmd '^[[1;7C' redo		# Ctrl + Alt + RightArrow
