# gcloud SDK
export CLOUDSDK_PYTHON=python3
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/application_default_credentials.json"
if [ -f "$HOME/.local/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/.local/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/.local/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/.local/google-cloud-sdk/completion.zsh.inc"; fi

# Direnv
_evalcache direnv hook zsh

# thefuck
if command -v thefuck 1>/dev/null 2>&1; then
  _evalcache thefuck --alias
fi

# autojump
[ -f $HOMEBREW_PREFIX/etc/profile.d/autojump.sh ] && . $HOMEBREW_PREFIX/etc/profile.d/autojump.sh

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true
gpip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
gpip3(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

# ssh-agent (mostly for git)
if [ $(ps ax | grep "[s]sh-agent" | wc -l) -eq 0 ] ; then
  eval $(ssh-agent -s) > /dev/null
  if [ "$(ssh-add -l)" = "The agent has no identities." ] ; then
    if [ $(uname) = "Darwin" ]; then
      ssh-add --apple-use-keychain > /dev/null 2>&1
    fi
  fi
fi

# pyenv
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
  if command -v pyenv 1>/dev/null 2>&1; then
    _evalcache pyenv init --no-rehash -
  fi
  if command -v pyenv-virtualenv-init 1>/dev/null 2>&1; then
    _evalcache pyenv virtualenv-init -
  fi
fi

# windmill
if command -v wmill 1>/dev/null 2>&1; then
  source <(wmill completions zsh)
fi

# iterm2 shell integration
if [ -f ~/.iterm2_shell_integration.zsh ]; then
  source ~/.iterm2_shell_integration.zsh
else
  curl -L https://iterm2.com/shell_integration/zsh -o ~/.iterm2_shell_integration.zsh
  source ~/.iterm2_shell_integration.zsh
fi

# fzf (fuzzy find)
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
export FZF_CTRL_R_OPTS='--sort --exact'
_fzf_init="$HOME/.config/zsh-plugins/.fzf.zsh"
[ -f "$_fzf_init" ] && source "$_fzf_init"
unset _fzf_init

# acme.sh
if [ -d "$HOME/.acme.sh" ]; then
  source "$HOME/.acme.sh/acme.sh.env"
fi

# fnm (fast node manager)
if command -v fnm 1>/dev/null 2>&1; then
  eval "$(fnm env --use-on-cd --shell zsh)"
fi

# pnpm
if command -v pnpm 1>/dev/null 2>&1; then
  export PNPM_HOME="$HOME/.local/share/pnpm"
  case ":$PATH:" in
    *":$PNPM_HOME/bin:"*) ;;
    *) export PATH="$PNPM_HOME/bin:$PATH" ;;
  esac
fi

