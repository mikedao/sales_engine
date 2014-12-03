require 'csv'
require_relative 'transaction'

class TransactionRepository
  attr_reader :transactions,
              :sales_engine

  def initialize(parent)
    @transactions = []
    @sales_engine = parent
  end

  def inspect
    "#<#{self.class} #{@transactions.size} rows>"
  end

  def load_data(data)
    data.map do |row|
      @transactions << Transaction.new(row, self)
    end
  end


  def <<(data)
    @transactions << Transaction.new(data, self)
  end

  def all
    @transactions
  end

  def random
    @transactions.sample
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

  def find_all_successful_by_invoice_id(criteria)
    find_all_by_invoice_id(criteria).select do |trans|
      trans.result == "success"
    end
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
    @transactions.find do |datum|
      datum.send(attribute) == criteria
    end
  end

  def finder_all_by(attribute, criteria)
    result = @transactions.find_all do |datum|
      datum.send(attribute) == criteria
    end
    result.nil? ? [] : result
  end

  def find_invoice(id)
    sales_engine.find_invoice_by_id(id)
  end

  def create_transaction(attributes, id)
    data = {
          id: "#{transactions.last.id + 1}",
          invoice_id: id,
          credit_card_number: attributes[:credit_card_number],
          credit_card_expiration_date: attributes[:credit_card_expiration_date],
          result: attributes[:result],
          created_at: "#{Date.new}",
          updated_at: "#{Date.new}"
           }

    transaction = Transaction.new(data, self)
    @transactions << transaction
  end

end
