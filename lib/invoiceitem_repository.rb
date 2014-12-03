require 'csv'
require_relative 'invoiceitem'

class InvoiceItemRepository
  attr_reader   :invoice_items,
                :sales_engine

  def initialize(parent)
    @invoice_items = []
    @sales_engine = parent
  end

  def inspect
    "#<#{self.class} #{@invoice_items.size} rows>"
  end

  def <<(data)
    @invoice_items << InvoiceItem.new(data, self)
  end

  def csv_loader(path = '../sales_engine/data/invoice_items.csv')
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @invoice_items << InvoiceItem.new(data, self)
    end
  end

  def all
    @invoice_items
  end

  def random
    @invoice_items.sample
  end

  def find_by_id(criteria)
    finder_by(:id, criteria)
  end

  def find_all_by_id(criteria)
    finder_all_by(:id, criteria)
  end

  def find_by_item_id(criteria)
    finder_by(:item_id, criteria)
  end

  def find_all_by_item_id(criteria)
    finder_all_by(:item_id, criteria)
  end

  def find_by_invoice_id(criteria)
    finder_by(:invoice_id, criteria)
  end

  def find_all_by_invoice_id(criteria)
    finder_all_by(:invoice_id, criteria)
  end

  def find_by_quantity(criteria)
    finder_by(:quantity, criteria)
  end

  def find_all_by_quantity(criteria)
    finder_all_by(:quantity, criteria)
  end

  def find_by_unit_price(criteria)
    finder_by(:unit_price, criteria)
  end

  def find_all_by_unit_price(criteria)
    finder_all_by(:unit_price, criteria)
  end

  def find_by_created_at(criteria)
    finder_by(:created_at, criteria)
  end

  def find_all_by_created_at(criteria)
    finder_all_by(:created_at, criteria)
  end

  def find_by_updated_at(criteria)
    finder_by(:updated_at, criteria)
  end

  def find_all_by_updated_at(criteria)
    finder_all_by(:updated_at, criteria)
  end

  def finder_by(attribute, criteria)
    @invoice_items.find do |datum|
      datum.send(attribute) == criteria
    end
  end

  def finder_all_by(attribute, criteria)
    result = @invoice_items.find_all do |datum|
      datum.send(attribute) == criteria
    end
    result.nil? ? [] : result
  end

  def find_invoice(id)
    sales_engine.find_invoice_by_id(id)
  end

  def find_item(id)
    sales_engine.find_item_by_id(id)
  end

  def create_invoice_items(invoice_id, item, quantity)
		data = {
						id: "#{invoice_items.last.id + 1}",
						item_id: item.id,
						invoice_id: invoice_id,
						quantity: quantity,
						unit_price: item.unit_price,
						created_at: "#{Date.new}",
						updated_at: "#{Date.new}"
					 }
		@invoice_items << InvoiceItem.new(data, self)
	end

end
