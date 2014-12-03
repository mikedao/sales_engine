require_relative 'support'

class Transaction
  include Support

  attr_reader   :id,
                :invoice_id,
                :credit_card_number,
                :credit_card_expiration_date,
                :result,
                :created_at,
                :updated_at,
                :repository

  def initialize(data, parent)
    @id                           = data[:id].to_i
    @invoice_id                   = data[:invoice_id].to_i
    @credit_card_number           = data[:credit_card_number]
    @credit_card_expiration_date  = data[:credit_card_expiration_date]
    @result                       = data[:result]
    @created_at                   = date_scrubber(data[:created_at])
    @updated_at                   = date_scrubber(data[:updated_at])
    @repository                   = parent
  end

  def invoice
    repository.find_invoice(invoice_id)
  end

end
