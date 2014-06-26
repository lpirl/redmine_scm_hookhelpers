#!/bin/bash

# stop on any errors:
set -e

REDMINE_URL="http://example.com/redmine"
WS_KEY=yx42yx42yx42yx42yx42
GIT_ROOT=/var/repositories/git
GIT_REPO=`basename "$(pwd)"`

wget -O/dev/null --quiet \
    "${REDMINE_URL}/sys/fetch_changesets?root_url=${GIT_ROOT}/${GIT_REPO}&key=${WS_KEY}"
