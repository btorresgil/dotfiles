# Plugin-specific config (must be set before antidote sources the bundle)
export NVM_LAZY_LOAD=true
export NVM_AUTO_USE=true
ZSH_POETRY_AUTO_ACTIVATE=0
ZSH_POETRY_AUTO_DEACTIVATE=0

ZSH_PLUGINS_TXT="$HOME/.config/zsh/.zsh_plugins.txt"
# Generated bundle goes to cache (not the stowed config dir, which is the repo)
ZSH_PLUGINS_SH="$HOME/.cache/zsh/.zsh_plugins.sh"
mkdir -p "${ZSH_PLUGINS_SH:h}"

source "$HOME/.config/zsh-plugins/venv.plugin.zsh"
source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh
alias zsh-update-plugins='antidote bundle < "$ZSH_PLUGINS_TXT" > "$ZSH_PLUGINS_SH"'

# Load antidote plugins (regenerate if cache missing)
if [ ! -f "$ZSH_PLUGINS_SH" ]; then
  zsh-update-plugins
fi
source "$ZSH_PLUGINS_SH"
