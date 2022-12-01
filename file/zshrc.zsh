declare -A ZINIT
ZINIT[BIN_DIR]="$HOME/.config/zsh/bin"
ZINIT[HOME_DIR]="$HOME/.config/zsh"

source "${ZINIT[BIN_DIR]}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# path
export HOMEBREW_PREFIX="$(/opt/homebrew/bin/brew --prefix)"

export PATH="$HOME/.local/bin:/usr/local/sbin:$HOMEBREW_PREFIX/bin:$PATH"
export FPATH="$HOMEBREW_PREFIX/share/zsh/site-functions:$FPATH"

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

source "$HOMEBREW_PREFIX/opt/fzf/shell/key-bindings.zsh"

zinit snippet "https://raw.githubusercontent.com/MichaelAquilina/zsh-history-filter/master/zsh-history-filter.plugin.zsh"
export HISTORY_FILTER_EXCLUDE=(
	"AWS_ACCESS_KEY_ID"
	"AWS_SECRET_ACCESS_KEY"
	"AWS_SESSION_TOKEN"
	"AWS_SECURITY_TOKEN"
	"STITCH_TOKEN"
	"VAULT_TOKEN"
)

# zsh opt
setopt auto_cd

# language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# editor
export EDITOR='nvim'
alias vi=nvim
alias vim=nvim

# ssh
export SSH_KEY_PATH="~/.ssh/id_ed25519"

# git
zinit ice as"program" pick"git-ilog"
zinit light tzing/git-ilog

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
export HOMEBREW_NO_AUTO_UPDATE=1
export CFLAGS="-I$HOMEBREW_PREFIX/include"
export CPPFLAGS="-I$HOMEBREW_PREFIX/include"
export LIBRARY_PATH="$HOMEBREW_PREFIX/lib:$LIBRARY_PATH"
unset HOMEBREW_PREFIX

# python
export POETRY_HOME="$HOME/.local/poetry"
export PIPENV_VENV_IN_PROJECT=true

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
	TMUX_BIN=`which tmux`
	alias tmux-inner="$TMUX_BIN -f $HOME/.config/tmux/config-inner.tmux -S /tmp/tmux-$(id -u)-inner"
	if [[ -n $TMUX ]] then
		alias tmux="tmux-inner"
	else
		alias tmux="$TMUX_BIN -f $HOME/.config/tmux/config.tmux"
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

vault-setup() {
	local app_name=${1:-dev-vault}

	local s_error='\033[1;31m'
	local s_highlight='\033[1;33m'
	local s_info='\033[0;37m'
	local s_reset='\033[0m'

	printf "${s_highlight}>> login teleport${s_reset}\n"
	tsh apps login "$app_name"
	if [[ $? != 0 ]]; then
		printf "${s_error}failed to login teleport${s_reset}\n"
		return 1
	fi

	export VAULT_ADDR=$(tsh apps config -f uri "$app_name")
	export VAULT_CLIENT_KEY=$(tsh apps config -f key "$app_name")
	export VAULT_CLIENT_CERT=$(tsh apps config -f cert "$app_name")
	printf "${s_info}>> set VAULT_ADDR = '$VAULT_ADDR'${s_reset}\n"
	printf "${s_info}>> set VAULT_CLIENT_KEY = '$VAULT_CLIENT_KEY'${s_reset}\n"
	printf "${s_info}>> set VAULT_CLIENT_CERT = '$VAULT_CLIENT_CERT'${s_reset}\n"

	printf "${s_highlight}>> login vault${s_reset}\n"
	vault login -method=oidc
}

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
alias __netstat=$(which netstat)
netstat() {
	if [[ $# > 0 ]]; then
		__netstat $@
	else
		__netstat -anv | awk 'NR<3 || /LISTEN/'
	fi
}
