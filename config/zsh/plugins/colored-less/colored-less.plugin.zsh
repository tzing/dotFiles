#!/usr/bin/zsh

SRC_HILIGHT='src-hilite-lesspipe.sh'


# source highlight
if type pygmentize > /dev/null; then
    export LESSOPEN="| $(which pygmentize) %s 2> /dev/null"
elif type $SRC_HILIGHT > /dev/null; then
    export LESSOPEN="| $(which $SRC_HILIGHT) %s"
fi


# colorized the underline
less () {
    env \
        LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
        LESS_TERMCAP_se=$(printf "\e[0m") \
        less "$@"
}
