class ItemRepository
  attr_accessor   :data

  def initialize
    @data = []
  end

  def <<(data)
    @data << data
  end

end
