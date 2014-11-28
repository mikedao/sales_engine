require_relative 'customer_repository'
require_relative 'invoice_repository'
require_relative 'invoiceitem_repository'
require_relative 'item_repository'
require_relative 'merchant_repository'
require_relative 'transaction_repository'

class SalesEngine
  attr_reader :customerrepository,
              :invoicerepository,
              :invoiceitemrepository,
              :itemrepository,
              :merchantrepository,
              :transactionrepository

  def startup
    @customerrepository     = CustomerRepository.new(self)
    @invoicerepository      = InvoiceRepository.new(self)
    @invoiceitemrepository  = InvoiceItemRepository.new
    @itemrepository         = ItemRepository.new(self)
    @merchantrepository     = MerchantRepository.new(self)
    @transactionrepository  = TransactionRepository.new(self)

    customerrepository.csv_loader
    invoicerepository.csv_loader
    invoiceitemrepository.csv_loader
    itemrepository.csv_loader
    merchantrepository.csv_loader
    transactionrepository.csv_loader
  end

  def find_items_by_merchant_id(id)
    itemrepository.find_all_by_merchant_id(id)
  end

  def find_invoices_by_merchant_id(id)
    invoicerepository.find_all_by_merchant_id(id)
  end


  def find_invoices_by_customer_id(id)
    invoicerepository.find_all_by_customer_id(id)
  end

  def find_transactions_by_invoice_id(id)
    transactionrepository.find_all_by_invoice_id(id)
  end

  def find_invoice_items_by_invoice_id(id)
    invoiceitemrepository.find_all_by_invoice_id(id)
  end

  def find_customer_by_id(id)
    customerrepository.find_all_by_id(id)
  end

  def find_invoice_items_by_item_id(id)
    invoiceitemrepository.find_all_by_item_id(id)
  end

end
