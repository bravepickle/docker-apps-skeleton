# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html). 
See "Upgrade guide" for each version that was recently updated during `git pull` to upgrade your 
local environment properly. It is recommended to manually update `APP_LOCAL_VERSION` in `.env` file to keep track 
of upgrades you've applied

## Notes
When in upgrade guides below is written "update your local environment to latest state" or similar phrasing 
without any specifics one can do the following:

1. Ensure that `.env` file enables all Docker profiles, e.g. `COMPOSE_PROFILES=frontend,backend,db,debug,websockets`
2. Backup or commit all local changes to all project repositories and their files
3. Run commands
    ```shell 
    $ make update
    $ docker compose pull
    $ docker compose up -d
    $ make install
    ```
4. Ensure that all commands are executed successfully without any warnings or errors

## Usage
1. Check your current version of `APP_LOCAL_VERSION`
2. If you see that the version diverged from latest of `CHANGELOG.md` then read through all notes of new versions
and follow upgrade guide instructions. Start reading from the next closest to your current version.
3. Run `make upgrade` to upgrade to latest version or update the version `APP_LOCAL_VERSION` manually

## [Unreleased] 

### Added
- init scripts for apps migration

### Changed
- upgrade PHP from v8.2 to v8.4
- update configs for apps
- update clickhouse version

### Upgrade guide
1. [Update](#notes) local environment to latest state

