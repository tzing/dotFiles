all: | collect install

install: install.nvim install.zsh install.pip install.tmux install.git install.bat
	#

collect: collect.nvim collect.zsh collect.tmux collect.git
	#

CYELLOW=$(shell tput setaf 3)
CCYAN=$(shell tput setaf 6)
CRESET:=$(shell tput sgr0)

#
# Section- neovim
#
DIR_NVIM_CONFIG=$(HOME)/.config/nvim
DIR_NVIM_AUTOLOAD=$(HOME)/.local/share/nvim/site/autoload

install.nvim: submodule.nvim
# backup init.vim
ifneq (,$(wildcard $(DIR_NVIM_CONFIG)/init.vim))
	@echo "$(CYELLOW)Backup $(CCYAN)init.vim$(CYELLOW) to $(CCYAN)$(DIR_NVIM_CONFIG)/init.bak.vim$(CRESET)"
	-mv -f $(DIR_NVIM_CONFIG)/init.vim $(DIR_NVIM_CONFIG)/init.bak.vim
endif

# zinit folder
	@echo "$(CYELLOW)Install configs$(CRESET)"
	mkdir -p $(DIR_NVIM_CONFIG) || true
	cp -af config/nvim/* $(HOME)/.config/nvim/

# the autoload file
ifeq (,$(wildcard $(DIR_NVIM_AUTOLOAD)/plug.vim))
	@echo "$(CYELLOW)Create neovim autoload file$(CRESET)"
	mkdir -p "$(DIR_NVIM_AUTOLOAD)" || true
	ln -s "$(DIR_NVIM_CONFIG)/vim-plug/plug.vim" "$(DIR_NVIM_AUTOLOAD)/plug.vim"
else
	@echo "$(CYELLOW)Autoload file existed$(CRESET)"
endif

submodule.nvim:
	git submodule update --init config/nvim/vim-plug

collect.nvim: $(DIR_NVIM_CONFIG)/init.vim
	cp $(DIR_NVIM_CONFIG)/init.vim config/nvim/init.vim


#
# 	Section- zsh
#
install.zsh: submodule.zsh
	# zshrc
ifneq (,$(wildcard $(HOME)/.zshrc))
	mv -f $(HOME)/.zshrc $(HOME)/.zshrc.bak || true
	@echo ">>> backup .zshrc to $(HOME)/.zshrc.bak"
endif
	cp file/zshrc.zsh $(HOME)/.zshrc

	# zinit folder
	mkdir -p $(HOME)/.config/zsh/bin || true
	cp -af config/zsh/bin/* $(HOME)/.config/zsh/bin

submodule.zsh:
	git submodule update --init config/zsh/bin

collect.zsh:
	cp $(HOME)/.zshrc file/zshrc.zsh


#
# 	Section- ssh
#
install.ssh:
	# .ssh folder
	mkdir $(HOME)/.ssh || true
	chmod u+rwx,go-rwx $(HOME)/.ssh

	# ssh config
ifneq (,$(wildcard $(HOME)/.ssh/config))
	mv -f $(HOME)/.ssh/config $(HOME)/.ssh/config.bak || true
	@echo ">>> backup .ssh/config to $(HOME)/.ssh/config.bak"
endif
	cp file/sshconfig $(HOME)/.ssh/config

collect.ssh:
	cp $(HOME)/.ssh/config file/sshconfig


#
# 	Section- pip
#
install.pip:
	mkdir -p $(HOME)/.config/pip
	cp -af config/pip/* $(HOME)/.config/pip


#
# 	Section- tmux
#
install.tmux: submodule.tmux
	mkdir -p $(HOME)/.config/tmux
	cp -af config/tmux/* $(HOME)/.config/tmux

submodule.tmux: submodule.tmux.sensible submodule.tmux.yank
	#

submodule.tmux.%:
	git submodule update --init config/tmux/tmux-$*

collect.tmux:
	cp $(HOME)/.config/tmux/*.tmux config/tmux/


#
#	Section- git
#
install.git: install.gitconfig install.gitignore
	#

install.git%:
	cp file/git$* $(HOME)/.git$* || true

collect.git:
	cp $(HOME)/.gitconfig file/gitconfig


#
#	Section- bat
#
install.bat:
	mkdir -p $(HOME)/.config/bat
	cp -af config/bat/* $(HOME)/.config/bat
