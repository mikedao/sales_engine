require 'csv'
require_relative 'invoice'

class InvoiceRepository
  attr_reader   :data,
                :sales_engine

  def initialize(parent)
    @data         = []
    @sales_engine = parent
  end

  def csv_loader(path = './data/invoices.csv')
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @data << Invoice.new(data, self)
    end
  end

  def <<(data)
    @data << Invoice.new(data,self)
  end

  def all
    @data
  end

  def random
    @data.sample
  end

  def find_by_id(criteria)
    @data.find do |datum|
      datum.id == criteria
    end
  end

  def find_all_by_id(criteria)
    @data.find_all do |datum|
      datum.id == criteria
    end
  end

  def find_by_customer_id(criteria)
    @data.find do |datum|
      datum.customer_id == criteria
    end
  end

  def find_all_by_customer_id(criteria)
    @data.find_all do |datum|
      datum.customer_id == criteria
    end
  end

  def find_by_merchant_id(criteria)
    @data.find do |datum|
      datum.merchant_id == criteria
    end
  end

  def find_all_by_merchant_id(criteria)
    @data.find_all do |datum|
      datum.merchant_id == criteria
    end
  end

  def find_by_status(criteria)
    @data.find do |datum|
      datum.status == criteria
    end
  end

  def find_all_by_status(criteria)
    @data.find_all do |datum|
      datum.status == criteria
    end
  end

  def find_by_created_at(criteria)
    @data.find do |datum|
      datum.created_at == criteria
    end
  end

  def find_all_by_created_at(criteria)
    @data.find_all do |datum|
      datum.created_at == criteria
    end
  end

  def find_by_updated_at(criteria)
    @data.find do |datum|
      datum.updated_at == criteria
    end
  end

  def find_all_by_updated_at(criteria)
    @data.find_all do |datum|
      datum.updated_at == criteria
    end
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
    sales_engine.find_successful_transactions_by_invoice_id(id).flatten
  end

end
