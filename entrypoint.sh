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

function buildDirectory {
         if [ "${INPUT_BUILD}" = "true" ]; then

            # Ensures a lambda layer is built properly
            if [ -d "./code/dependencies/nodejs" ] 
            then
               echo "running npm install on lambda layer in ./code/dependencies/nodejs"
               cd ./code/dependencies/nodejs
               npm install
               cd ../../..
            else
               echo "No layer to build in ./code/dependencies/nodejs"
            fi

            # Ensures a stand alone layer is built properly
            if [ -d "./dependencies/nodejs" ] 
            then
               if [ -d "./code" ]
               then
                  echo "running npm install on stand alone layer in ./code"
                  cd ./code
                  npm install
                  cd ..
               else
                  echo "No layer to build in ./code"
               fi
               echo "running npm install on layer ./dependencies/nodejs"
               cd ./dependencies/nodejs
               npm install
               cd ../..
            else
               echo "No layer to build in ./dependencies/nodejs"
            fi
            echo "executing sam build"
            sam build
            wait
         fi
}

gotoDirectory
buildDirectory

echo "executing sam $@"
exec sam "$@"