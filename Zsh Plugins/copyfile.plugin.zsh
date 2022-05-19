# Copies the contents of a given file to the clipboard
# copyfile <file>

function copyfile {
  emulate -L zsh
  xclip -in -sel clip $1
}
