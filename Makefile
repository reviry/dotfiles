CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), ls -dF $(val);)

install: ## Create symlink to home directory
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@ln -sfnv $(abspath config/*) ~/.config

install-karabiner: ## Create symlink of Karabiner
	@echo '==> Start to deploy Karabiner assets to home directory.'
	@echo ''
	@ln -sfnv $(abspath karabiner/assets) ~/.config/karabiner/assets
