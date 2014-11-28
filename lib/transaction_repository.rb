require 'csv'
require_relative 'transaction'


class TransactionRepository
  attr_reader :data


  def initialize
    @data = []
  end

  def csv_loader(path = 'data/transactions.csv')
    CSV.foreach(path, headers: true, header_converters: :symbol) do |data|
      @data << Transaction.new(data, self)
    end
  end

  def <<(data)
    @data << Transaction.new(data, self)
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

  def find_by_invoice_id(criteria)
    finder_by(:invoice_id, criteria)
  end

  def find_all_by_invoice_id(criteria)
    finder_all_by(:invoice_id, criteria)
  end

  def find_by_credit_card_number(criteria)
    finder_by(:credit_card_number, criteria)
  end

  def find_all_by_credit_card_number(criteria)
    finder_all_by(:credit_card_number, criteria)
  end

  def find_by_credit_card_expiration_date(criteria)
    finder_by(:credit_card_expiration_date, criteria)
  end

  def find_all_by_credit_card_expiration_date(criteria)
    finder_all_by(:credit_card_expiration_date, criteria)
  end

  def find_by_result(criteria)
    finder_by(:result, criteria)
  end

  def find_all_by_result(criteria)
    finder_all_by(:result, criteria)
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
