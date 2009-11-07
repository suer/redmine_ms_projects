class MsprojectsController < ApplicationController
  unloadable
  before_filter :find_project, :only => [:index, :select, :add]
  #before_filter :find_project, :only => [:select, :add]

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
    session[:tasks] = @tasks
  end

  def add
    @tasks = []
    @added_tasks = []
    params[:checked_items].each do |i|
      @tasks << session[:tasks][i.to_i]
    end
    tracker = Tracker.find 1
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
      @added_tasks << issue if issue.save
      issue.created_on = t.create_date
    end
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end
end
