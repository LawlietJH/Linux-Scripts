# Copies the path of given directory or file to the clipboard.
# Copy current directory if no parameter.

function copypath {
  # If no argument passed, use current directory
  local file="${1:-.}"

  # If argument is not an absolute path, prepend $PWD
  [[ $file = /* ]] || file="$PWD/$file"

  # Copy the absolute path without resolving symlinks
  # If clipcopy fails, exit the function with an error
  print -n "${file:a}" | xclip -in -sel clip || return 1

  echo ${(%):-"%B${file:a}%b copied to clipboard."}
}
