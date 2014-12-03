require 'csv'
require_relative 'invoice'

class InvoiceRepository
  attr_reader   :invoices,
                :sales_engine

  def initialize(parent)
    @invoices         = []
    @sales_engine = parent
  end

  def inspect
    "#<#{self.class} #{@invoices.size} rows>"
  end

  def csv_loader(path = '../sales_engine/data/invoices.csv')
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @invoices << Invoice.new(data, self)
    end
  end

  def <<(data)
    @invoices << Invoice.new(data,self)
  end

  def all
    @invoices
  end

  def random
    @invoices.sample
  end

  def find_by_id(criteria)
    @invoices.find do |datum|
      datum.id == criteria
    end
  end

  def find_all_by_id(criteria)
    result = @invoices.find_all do |datum|
      datum.id == criteria
    end
    result.nil? ? [] : result
  end

  def find_by_customer_id(criteria)
    @invoices.find do |datum|
      datum.customer_id.to_i == criteria.to_i
    end
  end

  def find_all_by_customer_id(criteria)
    result = @invoices.find_all do |datum|
      datum.customer_id.to_i == criteria.to_i
    end
    result.nil? ? [] : result
  end

  def find_by_merchant_id(criteria)
    @invoices.find do |datum|
      datum.merchant_id == criteria
    end
  end

  def find_all_by_merchant_id(criteria)
    result = @invoices.find_all do |datum|
      datum.merchant_id == criteria
    end
    result.nil? ? [] : result
  end

  def find_by_status(criteria)
    @invoices.find do |datum|
      datum.status == criteria
    end
  end

  def find_all_by_status(criteria)
    result = @invoices.find_all do |datum|
      datum.status == criteria
    end
    result.nil? ? [] : result
  end

  def find_by_created_at(criteria)
    @invoices.find do |datum|
      datum.created_at == criteria
    end
  end

  def find_all_by_created_at(criteria)
    result = @invoices.find_all do |datum|
      datum.created_at == criteria
    end
    result.nil? ? [] : result
  end

  def find_by_updated_at(criteria)
    @invoices.find do |datum|
      datum.updated_at == criteria
    end
  end

  def find_all_by_updated_at(criteria)
    result = @invoices.find_all do |datum|
      datum.updated_at == criteria
    end
    result.nil? ? [] : result

  end

  def find_transactions(id)
    sales_engine.find_transactions_by_invoice_id(id)
  end

  def find_invoice_items(id)
    sales_engine.find_invoice_items_by_invoice_id(id)
  end

  def find_customer(id)
    sales_engine.find_customer_by_id(id)
  end

  def find_merchant(id)
    sales_engine.find_merchant_by_id(id)
  end

  def find_invoice_items(id)
    sales_engine.find_invoice_items_by_invoice_id(id)
  end

  def find_successful_transactions(id)
    sales_engine.find_transactions_by_invoice_id(id).select do |trans|
      trans.result == "success"
    end
  end

  def create(attributes)
    data =  {
            id: "#{invoices.last.id + 1}",
            customer_id: attributes[:customer].id,
            merchant_id: attributes[:merchant].id,
            status: attributes[:status],
            created_at: "#{Date.new}",
            updated_at: "#{Date.new}"
            }

    invoice = Invoice.new(data, self)
    @invoices << invoice

    invoice_id = data[:id]
    unique_items = attributes[:items].uniq
    quantities = attributes[:items].group_by {|item| item}
    unique_items.each do |item|
      quant = quantities[item].count
        sales_engine.invoice_item_repository
        .create_invoice_items(invoice_id, item, quant)
      end
      invoice
    end

  def create_transaction(attributes, id)
    sales_engine.transaction_repository.create_transaction(attributes, id)
  end

end
