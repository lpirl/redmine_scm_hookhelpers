redmine_scm_hookhelpers
=======================

Helpers for commit hooks when using the [Redmine SCM plugin](http://www.redmine.org/plugins/redmine_scm).

This plugin is tested and developed with the current Redmine version (2.5).
Please drop me a note if you find [in]compatibilities with other versions.

description
-----------

Redmine offers a web service for repositories.
This can be used - for exmaple - to fetch all commits for all repositories.
Once your installation grows, this will get horrobly inefficient.
This plugin provides an extensions to the native web services API to fetch commits for specific repositories only.

Additionally to the parameters mentioned
[here](http://www.redmine.org/projects/redmine/wiki/HowTo_setup_automatic_refresh_of_repositories_in_Redmine_on_commit),
you can specify a `root_url` that is matched against the root URLs of all repositories.
Only the commits for the matching repositories will be fetched then.

example
-------

Assume you want to fetch the changesets for the repository stored in
`/var/repositories/git/administration.test.git`.
Then you simply would do a GET request on
`http://<redmine_url>/sys/fetch_changesets?root_url=%2Fvar%2Frepositories%2Fgit%2Ftest.git&key=<WS_key>`.

Ah, now you ask "why a local path?". Because you want to install post-commit hooks on the server like described [here](example_installation).

installation
------------

Just follow the plugin installation procedure at
http://www.redmine.org/projects/redmine/wiki/Plugins#Installing-a-plugin.
