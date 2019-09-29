#!/bin/zsh

BASEDIR="${0:A:h}"

SUBMODULE_SAMPLE="$BASEDIR/config/zsh/oh-my-zsh"

DIR_STANDALONE_FILES="file"

DIR_VIM_PLUG="$HOME/.vim/plugged"

EXCLUDE_DIRS=(
    $DIR_STANDALONE_FILES
    "others"
)


# test if git submodule is installed
if [[ -z "$(ls -A $SUBMODULE_SAMPLE)" ]]; then
    echo "initializing git submodule"
    git submodule update --init
fi


# install standalone config files
if type diff-so-fancy > /dev/null; then
    show_diff() {
        diff -u "$1" "$2" | diff-so-fancy
    }
else
    show_diff() {
        diff -u "$1" "$2"
    }
fi

for repo_file in $BASEDIR/$DIR_STANDALONE_FILES/*(.N); do
    local_file="$HOME/.${repo_file:t}"

    # hint and backup before replace
    if [[ -a "$local_file" ]] && [[ ! -z "$(diff $local_file $repo_file)" ]]; then
        local_file_short="$(echo $local_file | sed s^$HOME^~^)"

        echo "The following patch would be applied to $local_file_short:"
        show_diff "$local_file" "$repo_file"

        echo "Backup original file to $local_file_short.orig"
        echo ""
        cp "$local_file" "$local_file.orig"
    fi

    # replace file
    cp "$repo_file" "$local_file"
done


# copy directory
is_exclude() {
    [[ "${EXCLUDE_DIRS[(i)$directory]}" -le "${#EXCLUDE_DIRS}" ]]
}
for directory (./*(/)); do
    directory="${directory:t}"

    # skip if $directory in $EXCLUDE_DIRS
    if is_exclude "$directory"; then
        continue
    fi

    # create if $directory not exist
    if ! [[ -e "$HOME/.$directory" ]]; then
        # mkdir -p "$HOME/.$directory"
    fi

    cp -af "./$directory/." "$HOME/.$directory/"
done


# install vim config
if [[ -z "$(ls -A $DIR_VIM_PLUG)" ]]; then
    echo "install vim plugins"
    vim +PlugInstall
fi
