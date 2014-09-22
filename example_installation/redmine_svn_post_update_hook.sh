#!/bin/bash -x

# stop on any errors:
set -e

REDMINE_URL="http://example.com/redmine"
WS_KEY=xy42xy42xy42xy42
SVN_ROOT=file:///var/repositories/svn
SVN_REPO=`basename "$1"`

# make the API call asynchronous so users don't have to wait for it to
#  return upon commit:
#     * nohup prevents wget to receive SIGHUP and similar
#     * '>/dev/null 2>&1 &' detatches STDIN *and* STDERR

nohup wget -O/dev/null --quiet \
    "${REDMINE_URL}/sys/fetch_changesets?root_url=${SVN_ROOT}/${SVN_REPO}&key=${WS_KEY}" \
    >/dev/null 2>&1 &
