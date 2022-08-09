if [ "$(uname)" = "Darwin" ]; then
  FZF_PATH=/usr/local/opt/fzf
else
  FZF_PATH="$HOME/.fzf"
fi

# Setup fzf
# ---------
if [[ ! "$PATH" == *$FZF_PATH/bin* ]]; then
  export PATH="${PATH:+${PATH}:}$FZF_PATH/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZF_PATH/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$FZF_PATH/shell/key-bindings.zsh"
