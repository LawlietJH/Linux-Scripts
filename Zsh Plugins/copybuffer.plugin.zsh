# Copy buffer (current text on terminal) to clipboard with Ctrl+O

copybuffer () {
  echo -n $BUFFER | xclip -in -sel clip
}

# Add function to bindkey

zle -N copybuffer

bindkey -M emacs "^O" copybuffer	# Ctrl + O
bindkey -M viins "^O" copybuffer	# Ctrl + O
bindkey -M vicmd "^O" copybuffer	# Ctrl + O
