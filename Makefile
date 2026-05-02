DOTFILES := $(HOME)/.dotfiles

.PHONY: apply diff unstow bootstrap brew-macos-full help

help:
	@echo "Targets:"
	@echo "  apply      stow into ~/.config and ~ (home/)"
	@echo "  diff       dry-run: show what apply would change"
	@echo "  unstow     remove all symlinks managed by stow"
	@echo "  bootstrap  run script/bootstrap (stow install, OS Brewfile install, iTerm defaults)"
	@echo "  brew-macos-full  install full macOS Brewfile packages"

apply:
	cd $(DOTFILES) && stow -R .
	cd $(DOTFILES) && stow -t $(HOME) -R home

diff:
	cd $(DOTFILES) && stow -n -v -R .
	cd $(DOTFILES) && stow -n -v -t $(HOME) -R home

unstow:
	cd $(DOTFILES) && stow -D .
	cd $(DOTFILES) && stow -t $(HOME) -D home

bootstrap:
	$(DOTFILES)/script/bootstrap

brew-macos-full:
	brew bundle install --file $(DOTFILES)/Brewfile-macos-full
