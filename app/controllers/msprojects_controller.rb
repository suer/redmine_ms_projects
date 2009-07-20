class MsprojectsController < ApplicationController
	before_filter :find_project, :authorize, :only => :index

  helper :msprojects
  include MsprojectsHelper
	
  def index
		@project_id = params[:project_id]
		@xml = ""
		if request.post?
			xml = params[:file][:msproject].read
			parse_ms_project xml
		end
  end

  private
  def find_project
    @project = Project.find(params[:project_id])
  end
end
