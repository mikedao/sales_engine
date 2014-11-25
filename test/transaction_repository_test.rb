require_relative 'test_helper'
require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

class TransactionsRepositoryTest < Minitest::Test
  attr_reader :data1, :data2, :data3, :transaction_repository

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

  def load_test_data
    @transaction_repository = TransactionRepository.new
    transaction_repository << Transaction.new(data1)
    transaction_repository << Transaction.new(data2)
    transaction_repository << Transaction.new(data3)
  end


  def test_it_starts_empty
    transaction_repository = TransactionRepository.new
    assert transaction_repository.data.empty?
  end

  def test_it_has_transactions
    load_test_data
    assert_equal 3, transaction_repository.data.size
  end

  def test_it_can_access_individual_transactions
    load_test_data
    assert_equal "failed", transaction_repository.data[2].result
  end

  def test_all_method_returns_all_transactions
    load_test_data
    refute transaction_repository.all.empty?
    assert_equal 3, transaction_repository.all.size
    assert_equal transaction_repository.data, transaction_repository.all
  end

  def test_all_returns_an_array
    load_test_data
    assert transaction_repository.all.is_a?(Array)
  end

  def test_random_returns_one_transaction
    load_test_data
    assert transaction_repository.random.is_a?(Transaction)
  end

  def test_random_does_not_return_array_of_transactions
    load_test_data
    refute transaction_repository.random.is_a?(Array)
  end

  def test_find_by_id
    load_test_data
    result = transaction_repository.find_by_id(2)
    assert_equal 4654405418242222, result.credit_card_number
  end

  def test_find_all_by_id
    load_test_data
    result = transaction_repository.find_all_by_id(2)
    assert_equal 4654405418242222, result.first.credit_card_number
  end

end
