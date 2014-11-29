class Customer
  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at,
              :repository

  def initialize(data, parent)
    @id         = data[:id]
    @first_name = data[:first_name]
    @last_name  = data[:last_name]
    @created_at = data[:created_at]
    @updated_at = data[:updated_at]
    @repository = parent
  end

  def invoices
    repository.find_invoices(id)
  end

  def transactions
    invoices.map do |invoice|
      invoice.transactions
    end.flatten
  end

  def favorite_merchant
    successful_transactions = transactions.select do |transaction|
      transaction.result == "success"
    end

    successful_invoices = successful_transactions.map do |transaction|
      transaction.invoice
    end

    successful_merchants = successful_invoices.map do |invoice|
      invoice.merchant
    end

    successful_merchants.max_by { |merchies| successful_merchants.count(merchies) }
  end

end
