#!/bin/bash
# Performs a git pull against every sub-directory of the CWD. Will not pull when there are uncommitted changes.
# OSX: Requires 'brew install coreutils'

READLINK=($(which greadlink readlink))
GIT_BASE=$($READLINK -f .)
BRANCH="$1"
DIRTY_REPOS=""

cd $GIT_BASE
for DIR in $(find . -maxdepth 1 -type d); do
    REPO=$($READLINK -f $GIT_BASE/$DIR)
    if [ "$GIT_BASE" = "$REPO" ]; then
        continue
    fi  

    echo -n "$(basename $REPO) ... "
    cd $REPO
    if [ -z "$(git status --porcelain)" ]; then
        if [ -n "$BRANCH" ]; then
            $(git checkout $BRANCH 1>/dev/null 2>/dev/null)
        fi
        git pull 1>/dev/null 2>/dev/null
        echo "pulled."
    else
        echo "DIRTY."
        DIRTY_REPOS="${DIRTY_REPOS}\n$(basename `${REPO}`)"
    fi  

    cd $GIT_BASE    
done

if [ -n "$DIRTY_REPOS" ]; then
    echo -e "\nDIRTY:\n${DIRTY_REPOS}"
fi
