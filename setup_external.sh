#!/usr/bin/env bash

# Break on error
set -e 

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
echo "Checking external files needed in ${SCRIPT_DIR}"

if [ ! -d "${SCRIPT_DIR}/MOT16" ]; then
  echo "Installing mot challenge data in ${SCRIPT_DIR}/MOT16"  
  if [ ! -f "${SCRIPT_DIR}/MOT16.zip" ]; then
    curl https://motchallenge.net/data/MOT16.zip --output MOT16.zip
  fi
  unzip MOT16.zip -d "${SCRIPT_DIR}/MOT16"
  echo "Done installing mot challenge data in ${SCRIPT_DIR}/MOT16"  
else
  echo "Confirmed mot challenge data in ${SCRIPT_DIR}/MOT16"
fi

# The drive download below uses the gdown library, which enables downloading
# large files from Google Drive.  gdown is in the conda env.
DRIVE_URL="https://drive.google.com/file/d/1ORgtZ-BS4knA-nLzbTRgQZgQbGmg0ctt"
DRIVE_URL="https://drive.google.com/uc?id=1SbAqZJAPDZ92knT0KMviGWdF5cErP1AT"
if [ ! -d "${SCRIPT_DIR}/resources" ]; then
  echo "Installing model resources in ${SCRIPT_DIR}/resources"  
  set -x
  gdown "${DRIVE_URL}"
  set +x
  unzip "${SCRIPT_DIR}/resources-20210916T171747Z-001.zip"
  echo "Done installing model resources in ${SCRIPT_DIR}/resources"  
else
  echo "Confirmed model resources in ${SCRIPT_DIR}/resources"
fi

echo "*** Confirmed all externally-sourced files needed in ${SCRIPT_DIR} ***"

