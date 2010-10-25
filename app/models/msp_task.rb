class MspTask
  attr_accessor :task_id
  attr_accessor :name
  attr_accessor :resource
  attr_accessor :start_date
  attr_accessor :finish_date
  attr_accessor :create_date
  attr_accessor :parent
  attr_accessor :create
  attr_accessor :outline_level
  attr_accessor :outline_number
  attr_accessor :wbs

  def create?
    @create
  end
end
