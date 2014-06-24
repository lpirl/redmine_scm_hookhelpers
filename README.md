redmine_scm_hookhelpers
=======================

Helpers for commit hooks when using the Redmine SCM plugin.

This plugin is tested and developed with the current Redmine version (2.5).
Please drop me a note if you find [in]compatibilities with other versions.

description
-----------

Additionally to the parameters mentioned
[here](http://www.redmine.org/projects/redmine/wiki/HowTo_setup_automatic_refresh_of_repositories_in_Redmine_on_commit),
you can specify a `root_url` that is matched against the root URLs of all repositories.

example
-------

Assume you want to fetch the changesets for the repository stored in
`/var/repositories/git/administration.test.git`.
Then you simply would do a GET request on
`http://<redmine_url>/sys/fetch_changesets?root_url=%2Fvar%2Frepositories%2Fgit%2Ftest.git&key=<WS_key>`.

installation
------------

Just follow the plugin installation procedure at
http://www.redmine.org/projects/redmine/wiki/Plugins#Installing-a-plugin.
