#!/usr/bin/env bash
# Common script for setting up shell scripts

BASE_DIR="$( dirname $( cd "$( dirname "$(realpath ${BASH_SOURCE})" )" && pwd ))"

if [ ! -f $BASE_DIR/.env ]; then
    echo ".env not file at path: ${BASE_DIR}"

    exit 1
fi

# automatically export all variables from .env file
set -a
source $BASE_DIR/.env
set +a

CL_RED=`tput setaf 1`
CL_GREEN=`tput setaf 2`
CL_YELLOW=`tput setaf 3`
CL_BLUE=`tput setaf 4`
CL_RESET=`tput sgr0`
TARGET_DIR=data

run_cmd() {
    echo -e "${CL_GREEN}=> ${@}${CL_RESET}"
    echo ""
    $@
}

echo "BASE_DIR = ${BASE_DIR}"
run_cmd cd $BASE_DIR
