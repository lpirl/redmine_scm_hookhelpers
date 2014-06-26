#!/usr/bin/python3
# coding: UTF-8

import os
import sys
import argparse

"""
This scripts symlinks all corresponding required hook scripts
(also in this repo) to newly created repositories.

It'll be invoked by the Redmine SCM plugin like described here:
http://projects.andriylesyuk.com/projects/scm-creator/wiki/Scripts
"""

if __name__ != "__main__":
    raise NotImplementedError(
        "This module does nothing when not directly invoked."
    )

# config ###############################################################
#
#
HOOKS_PATH = os.path.dirname(sys.argv[0])
""" the path where the hooks will be searched in """

HOOKS_TO_LINK = {
    'svn': ('hooks/post-commit', "redmine_svn_post_update_hook.sh",),
    'git': ('hooks/post-update', "redmine_git_post_update_hook.sh",),
}
"""
A dict of mapping from a repository type to a 2-tuple:
    (<hook name>, <script to link>)
    Where
        * <hooke name> will be relative to repository root and
        * <script to link> relative to `HOOKS_PATH`.
The tuple specifies which hooks to link to what script.
"""

# functions ############################################################
#
#
def print_and_exit(*args, **kwargs):
    print(*args, **kwargs)
    sys.exit(1)

# parse CLI args #######################################################
#
#
parser = argparse.ArgumentParser(description=__doc__)
parser.add_argument('repository_path', type=str,
                    help='path to the repository root')
parser.add_argument('repository_type', type=str,
                    help='type of the repository (svn, git, …)')
parser.add_argument('project_id', type=str,
                    help='identifier of the Redmine project')
args = parser.parse_args()

# sanitize, verify, go #################################################
#
#

# do we have a configuration for the repository type?
repository_type = args.repository_type.lower()
if repository_type not in HOOKS_TO_LINK:
    print_and_exit(
        "could not find any specified hooks to link for:",
        repository_type
    )
hook_target, hook_source = HOOKS_TO_LINK.get(repository_type)

# is the hook source okay?
hook_source = os.path.join(HOOKS_PATH, hook_source)
hook_source = os.path.abspath(hook_source)
if not os.path.isfile(hook_source):
    print_and_exit("could not find hook:", hook_source)
if not os.access(hook_source, os.X_OK):
    print_and_exit("hook not executable:", hook_source)

# is the hook tarket okay?
hook_target = os.path.join(args.repository_path, hook_target)
hook_target = os.path.abspath(hook_target)
hook_target_dir = os.path.dirname(hook_target)
if not os.path.isdir(hook_target_dir):
    print_and_exit("target hook directory not found:", hook_target_dir)
if os.path.exists(hook_target):
    print_and_exit("target hook already exists:", hook_target)

# go!
os.symlink(hook_source, hook_target)
print("linked '{0}' -> '{1}'".format(hook_target, hook_source))
