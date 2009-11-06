class MsprojectsController < ApplicationController
  unloadable
  before_filter :find_project, :authorize, :only => :index

  helper :msprojects
  include MsprojectsHelper
  
  def index
    xml = ""
    tracker = Tracker.find 1
    @added_tasks = []
    if request.post?
      xml = params[:file][:msproject].read
      @tasks = parse_ms_project(xml)
      @tasks.each do |t|
        param = {
          :subject => t.name
        }
        issue = Issue.new param
        issue.project = @project
        issue.tracker = tracker
        issue.author = User.current
        issue.start_date = t.start_date
        issue.due_date = t.finish_date
        issue.updated_on = t.create_date
        @added_tasks << t if issue.save
        issue.created_on = t.create_date
      end
    end
    
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end
end
