#!/bin/bash
# Render files from templates

source $(dirname "$0")/common_init.sh

TEMPLAR_PATH=$(which templar)
set -e

echo -e "\n${CL_GREEN}Building templates...${CL_RESET}\n"

if [[ "${TEMPLAR_PATH}" == "" ]]; then
    echo "Templating engine ${CL_YELLOW}Templar${CL_RESET} not found. Falling back to Docker usage..."

    docker run --rm --name templar -v ./.env:/app/.env \
      -v ./etc/common/templates:/app/templates \
      bravepickle/templar build \
      --format=env --input=.env -d /app \
      --template=templates/hosts.tpl > etc/common/hosts

#    docker run --rm --name templar -v ./.env:/app/.env \
#      -v ./etc/nginx/templates:/app/templates \
#      bravepickle/templar build \
#      --format=env --input=.env -d /app \
#      --template=templates/nginx.conf.tpl > etc/nginx/conf/nginx.conf
else
    echo "Templating engine ${CL_YELLOW}Templar${CL_RESET} is installed. Using it..."

    run_cmd templar build \
      --format=env --input=.env -d $BASE_DIR \
      --template=etc/common/templates/hosts.tpl \
      --output etc/common/hosts

#    run_cmd templar build \
#      --format=env --input=.env -d $BASE_DIR \
#      --template=etc/nginx/templates/nginx.conf.tpl \
#      --output etc/nginx/conf/nginx.conf
fi

echo -e "\n${CL_GREEN}All templates are rendered successfully!${CL_RESET}\n"
