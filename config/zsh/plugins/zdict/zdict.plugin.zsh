#!/bin/zsh

BASEDIR=${0:A:h}
ENVDIR=$BASEDIR/_zdict_env


# create the venv in the first time
if [ ! -d $ENVDIR ]; then
    echo 'Building environment for zdict... (This will run only once)'

    python3 -m venv $ENVDIR > /dev/null 2> /dev/null
    $ENVDIR/bin/pip install zdict > /dev/null 2> /dev/null

    echo 'Done.'
fi


zdict() {
    $ENVDIR/bin/zdict $@
}
