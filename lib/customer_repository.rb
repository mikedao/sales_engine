require 'csv'
require_relative 'customer'

class CustomerRepository
  attr_reader :customers,
              :sales_engine

  def initialize(parent)
    @customers = []
    @sales_engine = parent
  end

  def inspect
    "#<#{self.class} #{@customers.size} rows>"
  end

  def csv_loader(path = '../sales_engine/data/customers.csv')
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @customers << Customer.new(data,self)
    end
  end

  def <<(data)
    @customers << Customer.new(data, self)
  end

  def all
    @customers
  end

  def random
    @customers.sample
  end

  def find_by_id(criteria)
    finder_by(:id, criteria)
  end

  def find_all_by_id(criteria)
    finder_all_by(:id, criteria)
  end

  def find_by_first_name(criteria)
    finder_by(:first_name, criteria)
  end

  def find_all_by_first_name(criteria)
    finder_all_by(:first_name, criteria)
  end

  def find_by_last_name(criteria)
    finder_by(:last_name, criteria)
  end

  def find_all_by_last_name(criteria)
    finder_all_by(:last_name, criteria)
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
    @customers.find do |datum|
      datum.send(attribute) == criteria
    end
  end

  def finder_all_by(attribute, criteria)
    @customers.find_all do |datum|
      datum.send(attribute) == criteria
    end
  end

  def find_invoices(id)
    sales_engine.find_invoices_by_customer_id(id)
  end

end
