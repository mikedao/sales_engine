class Merchant
  attr_reader   :id,
                :name,
                :created_at,
                :updated_at,
                :repository

  def initialize(data, parent)
    @id         = data[:id]
    @name       = data[:name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = parent
  end

  def items
    repository.find_items(id)
  end

end
