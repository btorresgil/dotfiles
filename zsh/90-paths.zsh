# PATH additions (kept last so they take precedence)
export PATH="$HOMEBREW_PREFIX/opt/libpq/bin:$PATH"

# poetry
export PATH="$HOME/.poetry/bin:$PATH"

# pipx
export PATH="$HOME/.local/bin:$HOME/Library/Python/3.7/bin:$PATH"
export PATH="$HOMEBREW_PREFIX/sbin:$PATH"

# rust and cargo
export PATH="$HOME/.cargo/bin:$PATH"

# golang
export PATH="$HOME/go/bin:$PATH"

# deno
export PATH="$HOME/.deno/bin:$PATH"

# brew gnu tools
PATH="$HOMEBREW_PREFIX/opt/grep/libexec/gnubin:$PATH"

# kubectl plugins (krew)
export PATH="${PATH}:${HOME}/.krew/bin"

# user programs
PATH="$HOME/.bin:$PATH"

# brew openssl 1.1
PATH="$HOMEBREW_PREFIX/opt/openssl@1.1/bin:$PATH"

export PATH="$HOMEBREW_PREFIX/opt/qt/bin:$PATH"

# opencode
export PATH=/home/dralthiace/.opencode/bin:$PATH

# pnpm binaries
export PATH=/home/dralthiace/.local/share/pnpm:$PATH
