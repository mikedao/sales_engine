require 'csv'
require_relative 'item'

class ItemRepository
  attr_reader   :items,
                :sales_engine

  def initialize(parent)
    @items = []
    @sales_engine = parent
  end

  def inspect
    "#<#{self.class} #{@items.size} rows>"
  end

  def load_data(data)
    data.map do |row|
      @items << Item.new(row, self)
    end
  end

  def <<(data)
    @items << Item.new(data, self)
  end

  def all
    @items
  end

  def random
    @items.sample
  end

  def find_by_id(criteria)
    finder_by(:id, criteria)
  end

  def find_all_by_id(criteria)
    finder_all_by(:id, criteria)
  end

  def find_by_name(criteria)
    finder_by(:name, criteria)
  end

  def find_all_by_name(criteria)
    finder_all_by(:name, criteria)
  end

  def find_by_description(criteria)
    finder_by(:description, criteria)
  end

  def find_all_by_description(criteria)
    finder_all_by(:description, criteria)
  end

  def find_by_unit_price(criteria)
    finder_by(:unit_price, criteria)
  end

  def find_all_by_unit_price(criteria)
    finder_all_by(:unit_price, criteria)
  end

  def find_by_merchant_id(criteria)
    finder_by(:merchant_id, criteria)
  end

  def find_all_by_merchant_id(criteria)
    finder_all_by(:merchant_id, criteria)
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
    @items.find do |datum|
      datum.send(attribute) == criteria
    end
  end

  def finder_all_by(attribute, criteria)
    results = @items.find_all do |datum|
      datum.send(attribute) == criteria
    end
    results.nil? ? [] : results

  end

  def find_invoice_items(id)
    sales_engine.find_invoice_items_by_item_id(id)
  end

  def find_merchant(id)
    sales_engine.find_merchant_by_id(id)
  end

  def most_revenue(x)
    items.sort_by do |item|
      item.revenue.nil? ? 0 : item.revenue
    end.reverse.first(x)
  end

  def most_items(x)
    items.sort_by do |item|
      item.quantity_sold.nil? ? 0 : item.quantity_sold
    end.reverse.first(x)
  end

end
