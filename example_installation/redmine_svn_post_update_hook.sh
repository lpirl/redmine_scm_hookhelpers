#!/bin/bash -x

# stop on any errors:
set -e

REDMINE_URL="http://example.com/redmine"
WS_KEY=xy42xy42xy42xy42
SVN_ROOT=file:///var/repositories/svn
SVN_REPO=`basename "$1"`

wget -O/dev/null --quiet \
    "${REDMINE_URL}/sys/fetch_changesets?root_url=${SVN_ROOT}/${SVN_REPO}&key=${WS_KEY}"
