#!/bin/bash
# Upgrade APP_LOCAL_VERSION to latest state

BASE_DIR="$( dirname $( cd "$( dirname "$(realpath $BASH_SOURCE)" )" && pwd ))"

if [ ! -f $BASE_DIR/.env.dist ]; then
    echo ".env.dist not file at path: ${BASE_DIR}"

    exit 1
fi

# automatically export all variables from .env file
set -a
source $BASE_DIR/.env.dist
set +a

CL_YELLOW=`tput setaf 3`
CL_RESET=`tput sgr0`

CURRENT_APP_LOCAL_VERSION=$(grep 'APP_LOCAL_VERSION=' .env)

set -e

if [[ "${CURRENT_APP_LOCAL_VERSION}" == "APP_LOCAL_VERSION=${APP_LOCAL_VERSION}" ]]; then
    echo "You have the latest version. Skipping upgrade..."
else
    echo "New version is available"
    echo "Current version ENV param ${CL_YELLOW}${CURRENT_APP_LOCAL_VERSION}${CL_RESET}"

    sed "s/APP_LOCAL_VERSION=.*/APP_LOCAL_VERSION=${APP_LOCAL_VERSION}/g" -i ${BASE_DIR}/.env
    echo "Upgraded ENV param to ${CL_YELLOW}APP_LOCAL_VERSION=${APP_LOCAL_VERSION}${CL_RESET}. See ${CL_YELLOW}CHANGELOG.md${CL_RESET} for the upgrade guide."
fi
