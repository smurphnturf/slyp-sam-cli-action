#!/bin/bash

set -e

function gotoDirectory {
        if [ -z "${INPUT_DIRECTORY}" ]; then
                return 0
        fi

        if [ ! -d "${INPUT_DIRECTORY}" ]; then
                echo "Directory ${INPUT_DIRECTORY} does not exists."
                exit 127
        fi

        echo "cd ${INPUT_DIRECTORY}"
        cd $INPUT_DIRECTORY
}

gotoDirectory

if [ "$1" == "sh" ]; then
  echo "executing $@"
  exec "$@"
fi

echo "executing sam $@ --no-fail-on-empty-changeset"
exec sam "$@ --no-fail-on-empty-changeset"