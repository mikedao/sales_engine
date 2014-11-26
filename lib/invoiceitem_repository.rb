require 'csv'

class InvoiceItemRepository
  attr_reader   :data
  def initialize
    @data = []
  end

  def <<(data)
    @data << InvoiceItem.new(data, self)
  end

  def csv_loader(path = '../data/invoice_items.csv')
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @data << InvoiceItem.new(data,self)
    end
  end

  def all
    @data
  end

  def random
    @data.sample
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
    @data.find do |datum|
      datum.send(attribute) == criteria
    end
  end

  def finder_all_by(attribute, criteria)
    @data.find_all do |datum|
      datum.send(attribute) == criteria
    end
  end
end
