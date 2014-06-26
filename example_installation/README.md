Let's assume you have read [the main readme](../../..).

## How get the hooks installed?

Of curse, you can just copy/symlink your hook handlers to the corresponding directory of your repository.

But there is [redmine_scm_symlink_post_commit_hook.py](redmine_scm_symlink_post_commit_hook.py) to take away the burden of doing manual symlinking.

#### existing repositories

Nevermind, it'll be easy to set up the hooks for all your repositories:

    find /var/repositories/svn -maxdepth 1 -mindepth 1 | \
      xargs -L 1 -I{} \
        /path/to/redmine_scm_symlink_post_commit_hook.py {} svn

or

    find /var/repositories/git -maxdepth 1 -mindepth 1 | \
      xargs -L 1 -I{} \
        /path/to/redmine_scm_symlink_post_commit_hook.py {} git

        
respectively.

(Of curse, adapt the commands according to your setup)

#### automated installtion for new repositories

Nevertheless, the installation can be easily automated using the [Redmine SCM plugin](http://www.redmine.org/plugins/redmine_scm).

This gets called upon repository creation and will symlink the corresponding hook into the newly created repository.

To call this upon repository creation, edit Redmine's `config/scm.yml` accordingly. Example:

    $ cat config/scm.yml 
    production:
      ...
      post_create: /path/to/redmine_scm_symlink_post_commit_hook.py
      ...

Like documented [here](http://projects.andriylesyuk.com/projects/scm-creator/wiki/Scripts#Arguments), the script will receive the repository root path and the repository type as command line arguments.

## What do the hooks do?

Just have a look into (and adapt) the example handlers:
* [redmine_git_post_update_hook.sh](redmine_git_post_update_hook.sh)
* [redmine_svn_post_update_hook.sh](redmine_svn_post_update_hook.sh)

They will issue a HTTP GET Request on Redmine's web service API for repositories to trigger the retrieval of new commits for the specific repository.

## Anyways - why?

You can now receive [commit emails](http://www.redmine.org/plugins/redmine_diff_email-2014) instantly!

[References in commits](http://www.redmine.org/projects/redmine/wiki/RedmineSettings#Referencing-issues-in-commit-messages) will be parsed instantly.
