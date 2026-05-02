# Environment variables
export TERM="xterm-256color"
export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export EDITOR=vi
if command -v nvim 1>/dev/null 2>&1; then
  export EDITOR=nvim
  alias vi='nvim'
fi

export KUBE_EDITOR=$EDITOR
