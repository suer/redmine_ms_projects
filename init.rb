require 'redmine'

Redmine::Plugin.register :redmine_ms_projects do
  name 'Redmine Ms Projects plugin'
  author 'suer'
  description 'MS Project Importer for Redmine'
  version '0.0.2'

  project_module :msproject do
    permission :msprojects, {:msprojects => [:index]}, :public => true
  end
  menu :project_menu, :msprojects, { :controller => 'msprojects', :action => 'index' }, :caption => :msproject, :param => :project_id

end
