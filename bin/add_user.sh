#!/bin/sh
# Add user for the application

set -ex

if [ "$#" -ne 3 ]; then
  echo "Expects 3 arguments exacty.\n" >&2
  echo "Adds specified user to Alpine OS" >&2
  echo "Usage: ${0} [USER] [UID] [GID]\n" >&2
  echo "  Example: ${0} app_user 1000 1000" >&2

  exit 1
fi

APP_USER=${1}
APP_UID=${2}
APP_GID=${3}

export

# add group with name same as user
addgroup -g $APP_GID $APP_USER

# add an app user and setup group and some settings
adduser -g $APP_USER -G $APP_USER --uid $APP_UID --disabled-password $APP_USER
