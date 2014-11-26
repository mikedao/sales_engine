class TransactionRepository
  attr_reader :data


  def initialize
    @data = []
  end

  def <<(data)
    @data << data
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
    finder_by(:id, criteria)
  end

  def find_all_by_invoice_id(criteria)
    finder_all_by(:id, criteria)
  end

  def find_by_credit_card_number(criteria)
    finder_by(:id, criteria)
  end

  def find_all_by_credit_card_number(criteria)
    finder_all_by(:id, criteria)
  end

  def find_by_credit_card_expiration_date(criteria)
    finder_by(:id, criteria)
  end

  def find_all_by_credit_card_expiration_date(criteria)
    finder_all_by(:id, criteria)
  end

  def find_by_result(criteria)
    finder_by(:id, criteria)
  end

  def find_all_by_result(criteria)
    finder_all_by(:id, criteria)
  end

  def find_by_created_at(criteria)
    finder_by(:id, criteria)
  end

  def find_all_by_created_at(criteria)
    finder_all_by(:id, criteria)
  end

  def find_by_updated_at(criteria)
    finder_by(:id, criteria)
  end

  def find_all_by_updated_at(criteria)
    finder_all_by(:id, criteria)
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
