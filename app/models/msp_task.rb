class MspTask
  attr_accessor :name
  attr_accessor :resource
  attr_accessor :start_date
  attr_accessor :finish_date
  attr_accessor :create_date
  attr_accessor :parent
  attr_accessor :create

  def create?
    @create
  end
end
