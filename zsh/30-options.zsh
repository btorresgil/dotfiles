# Shell options and history
HISTFILE=$HOME/.zhistory
HISTSIZE=100000
SAVEHIST=$HISTSIZE
HISTORY_IGNORE="(doppler secrets set*)"

unsetopt correct
setopt always_to_end
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt inc_append_history
setopt share_history
setopt interactive_comments
setopt histignorespace
