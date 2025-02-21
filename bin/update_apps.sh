#!/bin/bash
# Update applications by running git pull
# Usage: ./update_apps.sh {branch}
#  {branch} - (optional) switch branch before update
# Example: ./update_apps.sh main

source $(dirname "$0")/common_init.sh

if [[ "${#}" == "0" ]]; then
    SWITCH_BRANCH_NAME=""
else
    SWITCH_BRANCH_NAME="$1"
fi

#set -e

echo -e "\n${CL_GREEN}======== Updating base environment... ========${CL_RESET}\n"

run_cmd cd ${BASE_DIR}
run_cmd git status -sb
if [[ "${SWITCH_BRANCH_NAME}" != "" ]]; then
    run_cmd git switch $SWITCH_BRANCH_NAME
fi
run_cmd git pull


echo -e "\n${CL_GREEN}All apps are updated successfully!${CL_RESET}\n"
