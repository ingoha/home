#!/bin/bash

CODE=""
CODEFILE="${1}"
SESSION_PATH="${2}"
LANG="Plain Text"
LOGIN=1
CLEANUP=0
SUBJECT="< `basename ${CODEFILE}` >"

if [ -z ${CODEFILE} ]; then
	echo "error: File not specified."
	echo "Usage: `basename ${0}` <file>"
	exit
fi

#if [ -z ${LANG} ]; then
#	LANG="Plain Text"
#fi

if [ -z ${SESSION_PATH} ]; then
	SESSION_PATH="/tmp/codepad.session"
	CLEANUP=1
else if [ ${3} = "-nologin" ]; then
	LOGIN=0
fi
fi

CODE=`php -r"echo urlencode('${SUBJECT}');"`"%0A"`urlencode-file.sh ${CODEFILE}`
LANG=`php -r"echo urlencode('${LANG}');"`

if [ ${LOGIN} -eq 1 ]; then
	codepad-login.sh ${SESSION_PATH}
fi

curl -e http://codepad.org -d lang=${LANG} -d code=${CODE} -d submit=Submit -L http://codepad.org -b ${SESSION_PATH} -s | grep "<a href=\"http://codepad.org/.*/raw.txt\">raw code</a>" | sed -E -e's/.*\.org\/([A-z0-9]+).*/http:\/\/codepad\.org\/\1/'

if [ ${CLEANUP} -eq 1 ]; then
	rm ${SESSION_PATH}
fi
