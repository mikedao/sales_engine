require 'bigdecimal'
class InvoiceItem
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
    @quantity   = BigDecimal.new(data[:quantity])
    @unit_price = BigDecimal.new(data[:unit_price])/100
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = parent
    @revenue    = BigDecimal.new(data[:unit_price])/100 * BigDecimal.new(data[:quantity])
  end

  def invoice
    repository.find_invoice(invoice_id)
  end

  def item
    repository.find_item(item_id)
  end

end
