FROM python:3.10-slim

RUN set -eux; \
	apt-get update; \
	apt-get install -y --no-install-recommends \
		curl \
		git \
		neovim \
		rsync \
		zsh \
		; \
	apt-get purge --auto-remove -o APT::AutoRemove::RecommendsImportant=false; \
	rm -rf /var/lib/apt/lists/*;

# taskfile
RUN set -exu; \
	sh -c "$(curl --location https://taskfile.dev/install.sh)" -- -d -b /usr/bin; \
	task --version

# poetry
RUN set -eux; \
	export PIP_NO_CACHE_DIR=1; \
	export PYTHONDONTWRITEBYTECODE=1; \
	curl https://install.python-poetry.org | POETRY_HOME=/usr/local python3 -; \
	poetry --version

# dotfiles
ADD . /srv/dotfiles

# vim
RUN set -eux; \
	cd /srv/dotfiles; \
	export SKIP_INTERACTIVE=1; \
	export SKIP_SUBMODULE_CHECKOUT=1; \
	task install/env/neovim;

# zsh env
RUN set -eux; \
	cd /srv/dotfiles; \
	\
	export SKIP_SUBMODULE_CHECKOUT=1; \
	task install/env/zsh; \
	\
	zsh -c 'source $HOME/.zshrc'; \
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
CMD echo sleeping... && sleep infinity
