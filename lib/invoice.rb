require_relative 'support'

class Invoice
  include Support

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
    @created_at  = date_scrubber(data[:created_at])
    @updated_at  = date_scrubber(data[:updated_at])
    @repository  = parent
  end

  def transactions
    repository.find_transactions(id)
  end

  def successful?
    transactions.any? { |transaction| transaction.result == "success"}
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

  def charge(attributes)
    repository.create_transaction(attributes, id)
  end

end
