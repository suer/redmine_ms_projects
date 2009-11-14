class MsprojectsController < ApplicationController
  unloadable
  before_filter :find_project, :only => [:index, :select, :add]

  helper :msprojects
  include MsprojectsHelper
  
  def index
    xml = ""
    @tasks = []
    @added_tasks = []
  end

  def select
    xml = params[:file][:msproject].read
    @tasks = parse_ms_project(xml)
    @trackers = @project.trackers
    session[:tasks] = @tasks
  end

  def add
    @tasks = []
    @added_tasks = []
    params[:checked_items].each do |i|
      @tasks << session[:tasks][i.to_i]
    end
    #tracker = Tracker.find 1
    @tasks.each_with_index do |t, i|
      param = {
        :subject => t.name
      }
      issue = Issue.new param
      issue.project = @project
      #issue.tracker = tracker
      issue.tracker_id = params[:trackers][params[:checked_items][i].to_i]
      issue.author = User.current
      issue.start_date = t.start_date
      issue.due_date = t.finish_date
      issue.updated_on = t.create_date
      @added_tasks << issue if issue.save
      issue.created_on = t.create_date
      flash[:notice] = l(:msp_read_message, @added_tasks.size)
    end
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end
end
