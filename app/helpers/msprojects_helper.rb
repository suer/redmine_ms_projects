require "rexml/document" 
module MsprojectsHelper

  def parse_ms_project xml
    tasks = []
    doc = REXML::Document.new xml 
    doc.elements.each('//Task') do |task_tag|
      task = Task.new
      name = task_tag.elements['Name']
      task.name = name.text  if name
      tasks << task
    end
    tasks
  end

end
