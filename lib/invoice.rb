class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, parent)
    @id          = data[:id]
    @customer_id = data[:customer_id]
    @merchant_id = data[:merchant_id]
    @status      = data[:status]
    @created_at  = data[:created_at]
    @updated_at  = data[:updated_at]
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
