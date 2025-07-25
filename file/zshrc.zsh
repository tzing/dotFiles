declare -A ZINIT
ZINIT[BIN_DIR]="$HOME/.config/zsh/bin"
ZINIT[HOME_DIR]="$HOME/.config/zsh"

source "${ZINIT[BIN_DIR]}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# path
if [[ "$OSTYPE" == "darwin"* ]]; then
	export HOMEBREW_PREFIX="$(/opt/homebrew/bin/brew --prefix)"
	export PATH="$HOMEBREW_PREFIX/bin:$HOMEBREW_PREFIX/sbin:$PATH"
	export FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH"
fi

export PATH="$HOME/.local/bin:/usr/local/sbin:$PATH"

# appearance
zinit snippet OMZL::theme-and-appearance.zsh
zinit snippet OMZP::colored-man-pages

zinit light tzing/clover.zsh-theme
zinit light zdharma-continuum/fast-syntax-highlighting

# key binding
HYPHEN_INSENSITIVE="true"  # for OMZL::completion.zsh
CASE_SENSITIVE="false"     # for OMZL::completion.zsh

zinit snippet OMZL::completion.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::key-bindings.zsh

autoload -Uz compinit && compinit

if [[ "$OSTYPE" == "darwin"* ]]; then
	source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
fi

# credentials
zinit snippet "https://raw.githubusercontent.com/MichaelAquilina/zsh-history-filter/master/zsh-history-filter.plugin.zsh"
export HISTORY_FILTER_EXCLUDE=(
	_TOKEN
	_PASSWORD
	ALIBABA_CLOUD_ACCESS_KEY_ID
	ALIBABA_CLOUD_ACCESS_KEY_SECRET
	AWS_ACCESS_KEY_ID
	AWS_SECRET_ACCESS_KEY
)

for name in $HISTORY_FILTER_EXCLUDE; do  # for completion
	export $name=
done
unset name

# zsh opt
setopt auto_cd

# language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# editor
if type nvim > /dev/null; then
	export EDITOR='nvim'
	alias vi=nvim
	alias vim=nvim
fi

# ssh
export SSH_KEY_PATH="~/.ssh/id_ed25519"

# misc
alias du='du -h -d1'
alias df='df -h'

if type htop > /dev/null; then
	alias top=htop
fi

zinit snippet OMZL::directories.zsh
zinit snippet OMZL::functions.zsh  # for OMZL::misc.zsh
zinit snippet OMZL::misc.zsh

# homebrew
if [[ "$OSTYPE" == "darwin"* ]]; then
	export CFLAGS="-I$HOMEBREW_PREFIX/include"
	export CPPFLAGS="-I$HOMEBREW_PREFIX/include"
	export LIBRARY_PATH="$HOMEBREW_PREFIX/lib:$LIBRARY_PATH"
	unset HOMEBREW_PREFIX

	export HOMEBREW_NO_ANALYTICS=1
	export HOMEBREW_NO_INSTALL_UPGRADE=1
	export HOMEBREW_NO_INSTALLED_DEPENDENTS_CHECK=1
fi

# python
export POETRY_HOME="$HOME/.local/poetry"
export PIPENV_VENV_IN_PROJECT=true

if type uv > /dev/null; then
	pip() {
		local subcmd="$1"
		case "$subcmd" in
			install)
				shift
				uv pip install $@
				;;
			*)
				command python3 -m pip $@
				;;
		esac
	}
fi

# temp dir
cdtemp() {
	export OLD_DIR="$(pwd)"
	export TEMP_DIR="$(mktemp -d)"
	cd "$TEMP_DIR"

	exittemp() {
		cd "$OLD_DIR"
		rm -rf "$TEMP_DIR"
		unset OLD_DIR
		unset TEMP_DIR
	}
}

# tmux
if type tmux > /dev/null; then
	if [[ -n $TMUX ]] then
		alias tmux-inner="command tmux -f $HOME/.config/tmux/config-inner.tmux -S /tmp/tmux-$(id -u)-inner"
	else
		alias tmux="command tmux -f $HOME/.config/tmux/config.tmux"
	fi
fi

# rsync
if type rsync > /dev/null; then
	alias rsync='rsync -rlptD -hhh --progress'
fi

# hashicrop vault
if type vault > /dev/null; then
	complete -o nospace -C $(which vault) vault
fi

# ripgrep
zinit ice from"gh-r" as"program" pick"ripgrep-*/rg"
zinit light BurntSushi/ripgrep

alias grep=rg

# bat
zinit ice from"gh-r" as"program" pick"bat-*/bat"
zinit light sharkdp/bat

less () {
	env \
		LESS_TERMCAP_so="$(printf '\e[1;44;33m')" \
		LESS_TERMCAP_se="$(printf '\e[0m')" \
		bat --pager "less -ci" --paging "always" "$@"
}

# docker
zinit ice as"completion"
zinit snippet https://github.com/docker/cli/blob/master/contrib/completion/zsh/_docker

# netstat
if type netstat > /dev/null; then
	netstat() {
		if [[ $# > 0 ]]; then
			command netstat $@
		else
			echo "${fg[yellow]}> netstat -anv | awk 'NR<3 || /LISTEN/'$reset_color" >&2
			command netstat -anv | awk 'NR<3 || /LISTEN/'
		fi
	}
fi

# kubectl
if type kubectl > /dev/null; then
	alias kube=kubectl
fi

# watch
if type viddy > /dev/null; then
	alias watch=viddy
fi

# teleport
if type tsh > /dev/null; then
	tsh-kill() {
		print '\x04' | tsh join --mode peer $1
	}
fi
