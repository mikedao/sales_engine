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

  def invoices
    repository.find_invoices(id)
  end

  def revenue
    merchant_transactions = invoices.map { |inv| inv.transactions }.flatten

    successful_transactions = merchant_transactions.select do |trans|
      trans.result == 'success'
    end

    successful_invoices = successful_transactions.map do |trans|
      trans.invoice
    end

    successful_invoice_items = successful_invoices.map do |inv|
      inv.invoice_items
    end.flatten

    revenue_each = successful_invoice_items.map do |inv_item|
      inv_item.unit_price.to_i * inv_item.quantity.to_i
    end

    revenue_each.reduce(0, :+)
  end

end
