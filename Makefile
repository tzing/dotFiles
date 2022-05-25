all: | collect install

install: install.vim install.zsh install.pip install.tmux install.git install.bat
	#

collect: collect.vim collect.zsh collect.tmux collect.git
	#

#
# Section- vim
#
install.vim: submodule.vim
	# vimrc
ifneq (,$(wildcard $(HOME)/.vimrc))
	mv -f $(HOME)/.vimrc $(HOME)/.vimrc.bak || true
	@echo ">>> backup .vimrc to $(HOME)/.vimrc.bak"
endif
	cp file/vimrc.vim $(HOME)/.vimrc

	# .vim folder
	mkdir $(HOME)/.vim || true
	cp -af vim/* $(HOME)/.vim

submodule.vim:
	git submodule update --init vim/vim-plug

collect.vim: $(HOME)/.vimrc
	cp $(HOME)/.vimrc file/vimrc.vim


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
	cp $(HOME)/.config/tmux/*.conf config/tmux/


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
