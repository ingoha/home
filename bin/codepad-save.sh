#!/bin/bash

codepad-login.sh /tmp/codepad.session
PASTE_URL=`codepad-paste.sh ${1} /tmp/codepad.session -nologin`

curl -e ${PASTE_URL} -L ${PASTE_URL}/save -b /tmp/codepad.session -s 2>&1 > /dev/null

rm /tmp/codepad.session

echo ${PASTE_URL}
