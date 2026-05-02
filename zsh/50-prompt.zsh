# Powerlevel9k/10k theme
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

# Suppress virtualenv/pyenv adding their own prefix to the prompt
# (P9K renders them via the virtualenv segment instead)
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
VIRTUAL_ENV_DISABLE_PROMPT=1

# Open new tabs in same directory (Apple Terminal)
if [[ "$TERM_PROGRAM" == "Apple_Terminal" ]]; then
  function chpwd {
    printf '\e]7;%s\a' "file://$HOSTNAME${PWD// /%20}"
  }
  chpwd
fi
