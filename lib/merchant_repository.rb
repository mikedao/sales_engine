require_relative 'merchant'

class MerchantRepository
  attr_reader :data

  def initialize
    @data = []
  end

  def <<(data)
    @data << Merchant.new(data, self)
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
