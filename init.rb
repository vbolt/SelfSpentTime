require 'own_time_entries_project_patch'
require 'own_time_entries_issue_patch'
Rails.configuration.to_prepare do
  Project.send(:include, OwnTimeEntriesProjectPatch)
  Issue.send(:include, OwnTimeEntriesIssuePatch)
end

# require 'dispatcher'
require 'projects_controller_patch'
require 'application_controller_patch'
ActionDispatch::Callbacks.to_prepare do
  ProjectsController.send(:include, OwnTimeEntries::ProjectsControllerPatch)
  ApplicationController.send(:include, OwnTimeEntries::ApplicationControllerPatch)
end

Redmine::Plugin.register :redmine_own_time_entries do
  name 'Redmine Own Time Entries plugin'
  author '//Twinslash'
  description 'Plugin to show users only own time entries in a project'
  version '0.0.1'
  url ''
  author_url 'http://twinslash.com'

  # This plugin version for redmine 2.1
  requires_redmine '2.1'

  project_module :time_tracking do
    permission :view_only_own_time_entries, { :view_only_own_time_entries => nil }
  end

end
