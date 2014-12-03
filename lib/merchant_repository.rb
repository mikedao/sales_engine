require 'csv'
require_relative 'merchant'

class MerchantRepository
  attr_reader :merchants,
              :sales_engine

  def initialize(parent)
    @merchants = []
    @sales_engine = parent
  end

  def inspect
    "#<#{self.class} #{@merchants.size} rows>"
  end

  def load_data(data)
    data.map do |row|
      @merchants << Merchant.new(row, self)
    end
  end



  def <<(data)
    @merchants << Merchant.new(data, self)
  end

  def all
    @merchants
  end

  def random
    @merchants.sample
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
    @merchants.find do |datum|
      datum.send(attribute) == criteria
    end
  end

  def finder_all_by(attribute, criteria)
    result = @merchants.find_all do |datum|
      datum.send(attribute) == criteria
    end
    result.nil? ? [] : result
  end

  def find_items(id)
    sales_engine.find_items_by_merchant_id(id)
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_merchant_id(id)
  end

  def most_revenue(x)
    merchants.sort_by { |datum| datum.revenue }.reverse.first(x)
  end

  def most_items(x)
    merchants.sort_by { |datum| datum.items_sold }.reverse.first(x)
  end

  def revenue(date)
    merchants.map { |datum| datum.revenue(date) }.reduce(0, :+)
  end
end
