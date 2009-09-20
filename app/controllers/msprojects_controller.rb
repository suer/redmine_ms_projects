class MsprojectsController < ApplicationController
  before_filter :find_project, :authorize, :only => :index

  helper :msprojects
  include MsprojectsHelper
  
  def index
    @project_id = params[:project_id]
    @project = Project.find @project_id
    @xml = ""
    tracker = Tracker.find 1
    if request.post?
      @xml = params[:file][:msproject].read
      tasks = parse_ms_project(@xml)
      tasks.each do |t|
        param = {
          :subject => t.name
        }
        issue = Issue.new param
        issue.project = @project
        issue.tracker = tracker
        issue.author = User.current
        issue.save!
      end
    end
    
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end
end
