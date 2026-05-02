# Enable autocompletions
autoload -Uz compinit

# Keep zcompdump out of $ZDOTDIR (which is the dotfiles repo via symlink)
ZCOMPDUMP="$HOME/.cache/zsh/zcompdump-${ZSH_VERSION}"
mkdir -p "${ZCOMPDUMP:h}"

# Only refresh auto completion if it has changed. Saves time.
if [ $(uname) = "Darwin" ]; then
  if [ ! -f "$ZCOMPDUMP" ] || [ $(date +'%j') != $(stat -f '%Sm' -t '%j' "$ZCOMPDUMP") ]; then
    compinit -i -d "$ZCOMPDUMP"
  else
    compinit -C -i -d "$ZCOMPDUMP"
  fi
else
  if [[ -n "$ZCOMPDUMP"(#qN.mh+24) ]]; then
    compinit -i -d "$ZCOMPDUMP"
  else
    compinit -C -i -d "$ZCOMPDUMP"
  fi
fi

zmodload -i zsh/complist

zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:::::' completer _expand _complete _ignored _approximate

fpath+=~/.zfunc
