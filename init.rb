require 'redmine'

Redmine::Plugin.register :redmine_ms_projects do
  name 'Redmine Ms Projects plugin'
  author 'suer'
  description 'This is a plugin for Redmine'
  version '0.0.1'

  permission :msprojects, {:msprojects => [:index]}, :public => true
  menu :project_menu, :msprojects, { :controller => 'msprojects', :action => 'index' }, :caption => :msprojects, :last => true, :param => :project_id

end
