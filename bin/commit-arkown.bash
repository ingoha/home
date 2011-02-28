#!/bin/bash

PROJECTS_BASE_PATH="${HOME}/project/roylauriesoftware"
PROJECTS="modelsql modeljson arkown arkown.api-service arkown.server-pull-daemon arkown.android"

for PROJECT in $PROJECTS; do
    echo "[commit] ${PROJECT}"
    PROJECT_PATH="${PROJECTS_BASE_PATH}/${PROJECT}"
    cd ${PROJECT_PATH}
    git add .
    git commit -am ${1}
    git push
done

echo "[commit] Done."
