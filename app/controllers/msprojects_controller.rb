class MsprojectsController < ApplicationController
  unloadable
  before_filter :find_project, :only => [:index, :select, :add]
  before_filter :list_issues, :only => [:index, :select, :add]

  helper :msprojects
  include MsprojectsHelper
  
  def index
    xml = ""
    @tasks = []
    @added_tasks = []
  end

  def select
    xml = params[:file][:msproject].read
    @tasks = parse_ms_project(xml, @issues)
    @resources = find_resources(xml)
    params[:file][:msproject].close
    @members = Member.find(:all, params[:project_id]).collect {|m| User.find_by_id m.user_id }
    @trackers = @project.trackers
    session[:tasks] = @tasks
  end

  def add
    @tasks = []
    @added_tasks = []
    @updated_tasks = []
    params[:checked_items].each do |i|
      @tasks << session[:tasks][i.to_i]
    end
    @tasks.each_with_index do |t, i|
      if t.create? 
        param = {
          :subject => t.name
        }
        issue = Issue.new param
      else
        issue = find_issue t.name, @issues
      end
      issue.project = @project
      issue.tracker_id = params[:trackers][params[:checked_items][i].to_i]
      issue.author = User.current
      issue.start_date = t.start_date
      issue.due_date = t.finish_date
      issue.updated_on = t.create_date
      issue.created_on = t.create_date
      if t.create?
        @added_tasks << issue if issue.save
      else
        @updated_tasks << issue if issue.save
      end
    end
    flash[:notice] = []
    flash[:notice] << l(:msp_read_message, @added_tasks.size)
    flash[:notice] << " "
    flash[:notice] << l(:msp_update_message, @updated_tasks.size)
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end

  def list_issues
    @issues = Issue.find :all, :conditions => ['project_id = ?', @project.id]
  end
  
  def find_issue name, issues
    issues.each do |issue|
      return issue if issue.subject == name
    end
    nil
  end
end
