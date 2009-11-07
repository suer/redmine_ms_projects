require 'redmine'

Redmine::Plugin.register :redmine_ms_projects do
  name 'Redmine Ms Projects plugin'
  author 'suer'
  description 'MS Project Importer for Redmine'
  version '0.0.2'

  permission :msprojects, {:msprojects => [:index]}, :public => true
  menu :project_menu, :msprojects, { :controller => 'msprojects', :action => 'index' }, :caption => :msproject, :last => true, :param => :project_id

end
