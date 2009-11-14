require "rexml/document" 
module MsprojectsHelper

  def parse_ms_project xml
    tasks = []
    doc = REXML::Document.new xml 
    doc.elements.each('//Task') do |task_tag|
      task = MspTask.new
      name = task_tag.elements['Name']
      task.name = name.text if name
      date = Date.new
      start_date = task_tag.elements['Start']
      task.start_date = start_date.text.split('T')[0] if start_date
      finish_date = task_tag.elements['Finish']
      task.finish_date = finish_date.text.split('T')[0] if finish_date
      create_date = task_tag.elements['CreateDate']
      date_time = create_date.text.split('T')
      task.create_date = date_time[0] + ' ' + date_time[1] if start_date
      tasks << task
    end
    tasks
  end

  def find_resources xml
    resources = []
    doc = REXML::Document.new xml 
    doc.elements.each('//Resource') do |resource_tag|
      resource = MspResource.new
      id = resource_tag.elements['ID']
      resource.id = id if id
      name = resource_tag.elements['Name']
      resource.name = name.text if name
      resources << resource
    end
    resources
  end

end
