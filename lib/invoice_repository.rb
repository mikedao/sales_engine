class InvoiceRepository
  attr_reader   :data

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
end
