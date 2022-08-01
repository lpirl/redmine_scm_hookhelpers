require 'redmine'

Redmine::Plugin.register :redmine_scm_hookhelpers do
  name 'Redmine Scm Hookhelpers plugin'
  author 'Lukas Pirl'
  author_url 'http://lukas-pirl.de/'
  description 'This Plugin provides helpers for commit hooks when using the Redmine SCM plugin.'
  version '0.1.0'
  url 'https://github.com/lpirl/redmine_scm_hookhelpers'
  requires_redmine :version_or_higher => '3.4.2'
end

Rails.configuration.to_prepare do
  SysController.send(:include, SysControllerPatch)
end
