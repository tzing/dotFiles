declare -A ZINIT
ZINIT[BIN_DIR]="$HOME/.config/zsh/bin"
ZINIT[HOME_DIR]="$HOME/.config/zsh"

source "${ZINIT[BIN_DIR]}/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# path
export PATH="$HOME/.local/bin:/usr/local/sbin:/opt/homebrew/bin:$PATH"

# oh-my-zsh
HYPEN_INSENSITIVE="true"
CASE_SENSITIVE="false"
zinit snippet OMZL::completion.zsh
zinit snippet OMZL::directories.zsh
zinit snippet OMZL::functions.zsh
zinit snippet OMZL::grep.zsh
zinit snippet OMZL::history.zsh
zinit snippet OMZL::key-bindings.zsh
zinit snippet OMZL::misc.zsh
zinit snippet OMZL::theme-and-appearance.zsh

# theme
zinit light tzing/clover.zsh-theme

# plugins
zinit snippet OMZP::colored-man-pages

zinit light zdharma-continuum/fast-syntax-highlighting
zinit light arzzen/calc.plugin.zsh

zinit ice as"program" pick"diff-so-fancy"
zinit light so-fancy/diff-so-fancy

zinit ice as"program" pick"git-ilog"
zinit light tzing/git-ilog

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

# completions
autoload -Uz compinit && compinit

# zsh opt
setopt auto_cd

# language environment
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# preferred editor
export EDITOR='vim'

# ssh
export SSH_KEY_PATH="~/.ssh/id_ed25519"

# alias
alias du='du -h -d1'
alias df='df -h'
alias vi=vim

if type htop > /dev/null; then
    alias top=htop
fi

# homebrew
export HOMEBREW_NO_AUTO_UPDATE=1

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

# colorize less
SRC_HILIGHT='src-hilite-lesspipe.sh'

if type pygmentize > /dev/null; then
    export LESSOPEN="| $(which pygmentize) %s 2> /dev/null"
elif type $SRC_HILIGHT > /dev/null; then
    export LESSOPEN="| $(which $SRC_HILIGHT) %s"
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
