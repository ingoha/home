#!/bin/bash

# Username defaults to the current username, unless ~/.codepad-username exists.
USERNAME=${USER}
COOKIE_FILEPATH="${1}"

if [ -z ${COOKIE_FILEPATH} ]; then	
	echo "Usage: `basename ${0}` <cookie file path>"
	echo "error: Cookie filepath not specified."
	exit
fi

if [ -f ${PWD}/.codepad-username ]; then
	USERNAME=`cat ${PWD}/.codepad-username`
fi

echo "Codepad password for \`${USERNAME}\`:"
read -s PASSWORD

curl -e http://codepad.org/login -d username=${USERNAME} -d password=${PASSWORD} -d submit=login -L http://codepad.org/login -b codepad-session -c ${COOKIE_FILEPATH} -s 2>&1 > /dev/null
