class TransactionRepository
  attr_reader :data

  def initialize
    @data = []
  end

  def <<(data)
    @data << data
  end
end
