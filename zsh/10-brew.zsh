# Homebrew detection and PATH setup (must come early)

if [ -d "/opt/homebrew/opt/zinit" ]; then
  ZINIT_HOME="/opt/homebrew/opt/zinit"
  source "${ZINIT_HOME}/zinit.zsh"
fi

# Homebrew autocompletions (must be before compinit)
# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
brew_locations=(
    "/opt/homebrew"
    "/usr/local"
    "/home/linuxbrew/.linuxbrew"
)
function check_homebrew {
    for location in "${brew_locations[@]}"
    do
        if [[ -d $location && -x $location/bin/brew ]]; then
            export HOMEBREW_PREFIX=$location
            return 0
        fi
    done
    export HOMEBREW_PREFIX=/opt/homebrew
}
check_homebrew

export PATH="$HOMEBREW_PREFIX/bin:$PATH"
if type brew &>/dev/null
then
  FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:${FPATH}"
fi

# brew on linux
[ -f /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

export HOMEBREW_UPDATE_PREINSTALL=0
export HOMEBREW_NO_ENV_HINTS=1
