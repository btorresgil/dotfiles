# For profiling startup time with zprof
# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Homebrew autocompletions (must be before compinit)
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Enable autocompletions
autoload -Uz compinit

# Only refresh auto completion if it has changed. Saves time.
if [ $(uname) = "Darwin" ]; then
  # This version is from https://carlosbecker.com/posts/speeding-up-zsh/
  if [ $(date +'%j') != $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]; then
    compinit -i
  else
    compinit -C -i
  fi
else
  # Taken from: https://gist.github.com/ctechols/ca1035271ad134841284
  if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit -i
  else
    compinit -C -i
  fi
fi

zmodload -i zsh/complist

# Save history so we get auto suggestions
HISTFILE=$HOME/.zhistory
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTORY_IGNORE="(doppler secrets set*)"

export TERM="xterm-256color"

# Options
unsetopt correct # disable autocorrect
#setopt auto_cd # cd by typing directory name if it's not a command
#setopt auto_list # automatically list choices on ambiguous completion
#setopt auto_menu # automatically use menu completion
setopt always_to_end # move cursor to end if word had one match
setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks # remove superfluous blanks from history items
setopt inc_append_history # save history entries as soon as they are entered
setopt share_history # share history between different instances
setopt interactive_comments # allow comments in interactive shells
setopt histignorespace # history not contain commands starting with space

# Improve autocompletion style
zstyle ':completion:*' menu select # select completions with arrow keys
zstyle ':completion:*' group-name '' # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# Plugins Settings
export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true
alias gi='git-ignore'
# ENHANCD_FILTER=fzy:fzf:peco
# ENHANCD_DOT_ARG="."
# ENHANCD_DOT_SHOW_FULLPATH=1
ZSH_POETRY_AUTO_ACTIVATE=0
ZSH_POETRY_AUTO_DEACTIVATE=0
source ~/.zfunc/venv.plugin.zsh
alias zsh-update-plugins='antibody bundle < ~/.zsh_plugins.txt > ~/.zsh_plugins.sh'

fpath+=~/.zfunc

export PYENV_VIRTUALENV_DISABLE_PROMPT=1
VIRTUAL_ENV_DISABLE_PROMPT=1

# Theme
POWERLEVEL9K_MODE='nerdfont-complete'

if [ "$HOST" = "oasis" ]; then
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(host dir virtualenv vcs)
else
  POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir virtualenv vcs)
fi
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status root_indicator background_jobs)
POWERLEVEL9K_PROMPT_ADD_NEWLINE=false
POWERLEVEL9K_STATUS_OK=false
POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
POWERLEVEL9K_SHORTEN_DELIMITER=""
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
DEFAULT_USER="btorresgil"
POWERLEVEL9K_CONTEXT_TEMPLATE="%n"
POWERLEVEL9K_VIRTUALENV_BACKGROUND="darkgreen"
POWERLEVEL9K_USER_ROOT_BACKGROUND="black"
POWERLEVEL9K_USER_ROOT_FOREGROUND="red"
POWERLEVEL9K_USER_SUDO_BACKGROUND="black"
POWERLEVEL9K_USER_SUDO_FOREGROUND="red"
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="red"
POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="black"
POWERLEVEL9K_INSTANT_PROMPT=quiet

# Open new tabs in same directory
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
  function chpwd {
    printf '\e]7;%s\a' "file://$HOSTNAME${PWD// /%20}"
  }

  chpwd
fi

export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# Customize to your needs...

export EDITOR=vim

# Add support for ctrl+o in fzf to open selected file in VS Code
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"

# GCP Credentials
#export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/devrel-cps-btorresgil-a3dc0c375571.json"
export GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/application_default_credentials.json"

# Load antibody plugins
if [ ! -d "~/Library/Caches/antibody" ]; then
  zsh-update-plugins
fi
source ~/.zsh_plugins.sh

if [[ "$TERM_PROGRAM" == 'iTerm.app' ]]; then
  source $HOME/Library/Caches/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-marzocchi-SLASH-zsh-notify/notify.plugin.zsh
  fpath+=( $HOME/Library/Caches/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-marzocchi-SLASH-zsh-notify )
elif [[ "$TERM_PROGRAM" == 'Apple_Terminal' ]]; then
  source $HOME/Library/Caches/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-marzocchi-SLASH-zsh-notify/notify.plugin.zsh
  fpath+=( $HOME/Library/Caches/antibody/https-COLON--SLASH--SLASH-github.com-SLASH-marzocchi-SLASH-zsh-notify )
fi

# Aliases

command -v exa >/dev/null && alias ls="exa"
command -v bat >/dev/null && alias cat='bat'
command -v prettyping >/dev/null && alias ping='prettyping --nolegend'
alias ncdu='ncdu --color dark -x --exclude .git --exclude node_modules'
alias preview="fzf --preview 'bat --color \"always\" {}'"
alias flushdns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"

alias bw-unlock='export BW_SESSION=`bw unlock --raw`'

alias urldecode='python -c "import sys, urllib.parse as ul; \
    print(ul.unquote_plus(sys.argv[1]))"'
alias urlencode='python -c "import sys, urllib.parse as ul; \
    print(ul.quote_plus(sys.argv[1]))"'

alias gh-browse='gh repo view --web'

alias zshtime='for i in $(seq 1 10); do /usr/bin/time zsh -i -c exit; done'

alias d='doppler'
alias dr='doppler run --'
alias dc='f() { doppler run --command=''$1'' };f'
alias ds='doppler secrets'
alias dss='doppler secrets set'
alias dsr='f() { doppler secrets set ''$2''="$(doppler secrets get ''$1'' --plain)"; doppler secrets delete ''$1'' -y --silent };f'
alias tf='doppler run --name-transformer tf-var -- terraform'
alias tg='doppler run --name-transformer tf-var -- terragrunt'

alias k='kubectl'

# docker-compose aliases

alias dcu='docker-compose up -d --remove-orphans'
alias dcr='docker-compose restart'
alias dcdown='docker-compose down --remove-orphans'
alias dcl='docker-compose logs --tail=300'
alias dce='docker-compose exec'
alias dcps='docker-compose ps'
alias dcp='docker-compose pull'

# SSH Aliases

alias sshproxy='ssh -o ProxyCommand="nc -X 5 -x 127.0.0.1:1080 %h %p"'
alias sshdirect='ssh -o ProxyCommand=""'
alias splunkaws='ssh -i ~/.ssh/AmazonKeyPair.pem ec2-user@splunk-aws.panw.biz'
alias oasis='ssh oasis'
alias splunk='gcloud compute --project "ixius-splunk" ssh --zone "us-west1-b" "splunk@splunk"'

# cert lookup

function seecert () {
  nslookup $1
  (openssl s_client -showcerts -servername $1 -connect $1:443 <<< "Q" | openssl x509 -text | grep -iA2 "Validity")
}

# gcloud SDK
export CLOUDSDK_PYTHON=python3
if [ -f "$HOME/.local/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/.local/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/.local/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/.local/google-cloud-sdk/completion.zsh.inc"; fi

# Direnv
# eval "$(direnv hook zsh)"
_evalcache direnv hook zsh
export PATH="/usr/local/opt/libpq/bin:$PATH"

# thefuck?
# eval $(thefuck --alias)
if command -v thefuck 1>/dev/null 2>&1; then
  _evalcache thefuck --alias
fi

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# brew on linux
[ -f /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# pip

# pip should only run if there is a virtualenv currently activated
export PIP_REQUIRE_VIRTUALENV=true

# create commands to override pip restriction.
# use `gpip` or `gpip3` to force installation of
# a package in the global python environment
gpip(){
   PIP_REQUIRE_VIRTUALENV="" pip "$@"
}
gpip3(){
   PIP_REQUIRE_VIRTUALENV="" pip3 "$@"
}

# pyenv
if [ -d "$HOME/.pyenv" ]; then
  export PYENV_ROOT="$HOME/.pyenv"
  export PATH="$PYENV_ROOT/bin:$PATH"
  if command -v pyenv 1>/dev/null 2>&1; then
    # eval "$(pyenv init --path)"
    # eval "$(pyenv init -)"
    _evalcache pyenv init --path
    _evalcache pyenv init -
  fi
  if command -v pyenv-virtualenv-init 1>/dev/null 2>&1; then
    # eval "$(pyenv virtualenv-init -)"
    _evalcache pyenv virtualenv-init -
  fi
fi

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# pipx
export PATH="$HOME/.local/bin:$HOME/Library/Python/3.7/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

# rust and cargo
export PATH="$HOME/.cargo/bin:$PATH"

# golang
export PATH="$HOME/go/bin:$PATH"

# homebrew
export HOMEBREW_UPDATE_PREINSTALL=0

# brew gnu tools
PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"

# kubectl plugins (krew)
export PATH="${PATH}:${HOME}/.krew/bin"

# broot
# source $HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br

# Keybindings
bindkey -v
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line
# bindkey '^ ' autosuggest-accept
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down
# bindkey '^[[3~' delete-char
# bindkey '^[3;5~' delete-char

# fzf (fuzzy find)
[ -f $HOME/.dotfiles/.fzf.zsh ] && source $HOME/.dotfiles/.fzf.zsh
export FZF_CTRL_R_OPTS='--sort --exact'

# user programs
PATH="$HOME/.bin:$PATH"

# brew openssl 1.1 (install with `brew install openssl@1.1`)
PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

if [ -d "$HOME/.acme.sh" ]; then
  source "$HOME/.acme.sh/acme.sh.env"
fi

export PATH="/usr/local/opt/qt/bin:$PATH"
