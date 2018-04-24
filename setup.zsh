#!/bin/zsh

dir_file="file"

exclude_dirs=(
    $dir_file
    "others"
)


# single file
for file (./$dir_file/*(.N)); do
    file=${file:t}

    # backup before overwrite
    if [[ -a $HOME/.$file ]]; then
        mv -v $HOME/.$file $HOME/.$file.orig
    fi

    cp $dir_file/$file $HOME/.$file
done


# copy directory
is_exclude() {
    [[ ${exclude_dirs[(i)$directory]} -le ${#exclude_dirs} ]]
}
for directory (./*(/)); do
    directory=${directory:t}

    # skip if $directory in $exclude_dirs
    if is_exclude $directory; then
        continue
    fi

    # create if $directory not exist
    if ! [[ -e "$HOME/.$directory" ]]; then
        mkdir -p "$HOME/.$directory"
    fi

    cp -af "./$directory/." "$HOME/.$directory/"
done
