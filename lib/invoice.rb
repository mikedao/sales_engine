class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, parent)
    @id          = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status      = data[:status]
    @created_at  = Date.parse(data[:created_at]).to_s
    @updated_at  = Date.parse(data[:updated_at]).to_s
    @repository  = parent
  end

  def transactions
    repository.find_transactions(id)
  end

  def successful_transactions
    repository.find_successful_transactions(id)
  end

  def successful_invoices
    successful_transactions.map do |transaction|
      transaction.invoice
    end
  end

  def invoice_items
    repository.find_invoice_items(id)
  end

  def customer
    repository.find_customer(customer_id)
  end

  def merchant
    repository.find_merchant(merchant_id)
  end

  def items
    invoice_items.map do |invoice_item|
      invoice_item.item
    end.flatten
  end

end
