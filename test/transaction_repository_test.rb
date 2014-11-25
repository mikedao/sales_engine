require_relative 'test_helper'
require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

class TransactionsRepositoryTest < Minitest::Test
  attr_reader :data1, :data2, :data3

  def setup
    @data1 = { id:                   "1",
               invoice_id:           "1",
               credit_card_number:   "4654405418241111",
               credit_card_expiration_date:  "",
               result:               "success",
               created_at:           "2012-03-27 14:54:09 UTC",
               updated_at:           "2012-03-27 14:54:09 UTC"
             }

    @data2 = { id:                   "2",
               invoice_id:           "2",
               credit_card_number:   "4654405418242222",
               credit_card_expiration_date:  "",
               result:               "success",
               created_at:           "2013-03-27 14:54:09 UTC",
               updated_at:           "2013-03-27 14:54:09 UTC"
             }

    @data3 = { id:                   "2",
               invoice_id:           "1",
               credit_card_number:   "4654405418249632",
               credit_card_expiration_date:  "",
               result:               "failed",
               created_at:           "2013-03-27 14:54:09 UTC",
               updated_at:           "2013-03-27 14:54:09 UTC"
              }

  end

  def test_it_starts_empty
    transaction_repository = TransactionRepository.new
    assert transaction_repository.data.empty?
  end

  def test_it_has_transactions
    transaction_repository = TransactionRepository.new
    transaction_repository << Transaction.new(data1)
    transaction_repository << Transaction.new(data2)
    transaction_repository << Transaction.new(data3)
    assert_equal 3, transaction_repository.data.size
  end

  def test_it_can_access_individual_transactions
    transaction_repository = TransactionRepository.new
    transaction_repository << Transaction.new(data1)
    transaction_repository << Transaction.new(data2)
    transaction_repository << Transaction.new(data3)
    assert_equal "failed", transaction_repository.data[2].result
  end

end
