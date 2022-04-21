declare -A ZINIT
ZINIT[BIN_DIR]="$HOME/.config/zsh/bin"
ZINIT[HOME_DIR]="$HOME/.config/zsh"

source "${ZINIT[BIN_DIR]}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# path
export PATH="$HOME/.local/bin:/usr/local/sbin:/opt/homebrew/bin:$PATH"

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

zinit ice from"gh-r" as"program"
zinit light junegunn/fzf-bin
zinit snippet "https://raw.githubusercontent.com/junegunn/fzf/master/shell/key-bindings.zsh"

zinit snippet "https://raw.githubusercontent.com/MichaelAquilina/zsh-history-filter/master/zsh-history-filter.plugin.zsh"
export HISTORY_FILTER_EXCLUDE=(
    "AWS_ACCESS_KEY_ID"
    "AWS_SECRET_ACCESS_KEY"
    "AWS_SESSION_TOKEN"
    "AWS_SECURITY_TOKEN"
)

# zsh opt
setopt auto_cd

# language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# preferred editor
export EDITOR='vim'

# ssh
export SSH_KEY_PATH="~/.ssh/id_ed25519"

# git
zinit ice as"program" pick"diff-so-fancy"
zinit light so-fancy/diff-so-fancy

zinit ice as"program" pick"git-ilog"
zinit light tzing/git-ilog

# misc
alias du='du -h -d1'
alias df='df -h'
alias vi=vim

if type htop > /dev/null; then
    alias top=htop
fi

zinit snippet OMZL::directories.zsh
zinit snippet OMZL::grep.zsh
zinit snippet OMZL::functions.zsh  # for OMZL::misc.zsh
zinit snippet OMZL::misc.zsh

zinit ice as"program"
zinit light romkatv/zshi

zinit light arzzen/calc.plugin.zsh

# homebrew
export HOMEBREW_NO_AUTO_UPDATE=1

# python
export POETRY_HOME="$HOME/.local/poetry"
export PIPENV_VENV_IN_PROJECT=true

venv() {
    zshi "source .venv/bin/activate"
}

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

# colorize less
if type pygmentize > /dev/null; then
    export LESSOPEN="| $(which pygmentize) %s 2> /dev/null"
fi

less () {
    env \
        LESS_TERMCAP_so="$(printf '\e[1;44;33m')" \
        LESS_TERMCAP_se="$(printf '\e[0m')" \
        less -i "$@"
}

# tmux
if type tmux > /dev/null; then
    TMUX_BIN=`which tmux`
    alias tmux-inner="$TMUX_BIN -f $HOME/.config/tmux/tmux-inner.conf -S /tmp/tmux-$(id -u)-inner"
    if [[ -n $TMUX ]] then
        alias tmux="tmux-inner"
    else
        alias tmux="$TMUX_BIN -f $HOME/.config/tmux/tmux.conf"
    fi
fi

# rsync
if type rsync > /dev/null; then
    alias rsync='rsync -rlptD -hhh --progress'
fi
