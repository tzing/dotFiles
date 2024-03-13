FROM photon:5.0

RUN set -eux; \
	tdnf install -y \
		git \
		python3 \
		python3-pip \
		rsync \
		vim \
		zsh \
		; \
	tdnf clean all; \
	openssl rehash;

# poetry
RUN set -eux; \
	export PIP_NO_CACHE_DIR=1; \
	export PYTHONDONTWRITEBYTECODE=1; \
	curl https://install.python-poetry.org | POETRY_HOME=/usr/local python3 -; \
	poetry --version;

# taskfile
RUN set -exu; \
	sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/bin; \
	task --version;

# dotfiles
ADD . /srv/dotfiles

# vim
RUN set -eux; \
	mkdir -p "$HOME/.vim/autoload/"; \
	ln -s /srv/dotfiles/config/nvim/vim-plug/plug.vim "$HOME/.vim/autoload/plug.vim"; \
	ln -s /srv/dotfiles/config/nvim/init.vim "$HOME/.vimrc"; \
	yes | vim '+PlugUpdate!' '+qall!';

# zsh env
RUN set -eux; \
	cd /srv/dotfiles; \
	\
	export SKIP_SUBMODULE_CHECKOUT=1; \
	task install/env/zsh; \
	\
	zsh "$HOME/.zshrc"; \
	# fix: ripgrep dir is owned by different user
	chown root:root -R "$HOME/.config/zsh/plugins/BurntSushi---ripgrep"; \
	\
	rm -rf "$HOME/.cache";

# bat
RUN set -eux; \
	cd /srv/dotfiles; \
	task install/config/bat;

# finalize
WORKDIR /root
CMD echo sleeping... && tail -f /dev/null

ENV TERM linux
SHELL ["/bin/zsh", "-c"]
