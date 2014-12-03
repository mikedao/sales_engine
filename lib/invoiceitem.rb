require 'bigdecimal'
require_relative 'support'

class InvoiceItem
  include Support
  
  attr_reader   :id,
                :item_id,
                :invoice_id,
                :quantity,
                :unit_price,
                :created_at,
                :updated_at,
                :repository,
                :revenue

  def initialize(data, parent)
    @id         = data[:id].to_i
    @item_id    = data[:item_id].to_i
    @invoice_id = data[:invoice_id].to_i
    @quantity   = data[:quantity].to_i
    @unit_price = BigDecimal.new(data[:unit_price])/100
    @created_at = date_scrubber(data[:created_at])
    @updated_at = date_scrubber(data[:updated_at])
    @repository = parent
    @revenue    = BigDecimal.new(data[:unit_price])/100 * data[:quantity].to_i
  end

  def invoice
    repository.find_invoice(invoice_id)
  end

  def item
    repository.find_item(item_id)
  end

end
