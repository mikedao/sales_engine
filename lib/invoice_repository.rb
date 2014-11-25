class InvoiceRepository
  attr_reader   :data
  
  def initialize
    @data = []
  end

  def <<(data)
    @data << data
  end

end
