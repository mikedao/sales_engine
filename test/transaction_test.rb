require_relative 'test_helper'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
  attr_reader   :data

  def setup
    @data = {  id:                   "1",
              invoice_id:           "1",
              credit_card_number:   "4654405418249632",
              credit_card_expiration_date:  "",
              result:               "success",
              created_at:           "2012-03-27 14:54:09 UTC",
              updated_at:           "2012-03-27 14:54:09 UTC"
            }
  end

  def test_has_an_id
    transaction = Transaction.new(data, nil)
    assert_equal 1, transaction.id
  end

  def test_has_an_invoice_id
    transaction = Transaction.new(data, nil)
    assert_equal 1, transaction.invoice_id
  end

  def test_has_a_credit_card_number
    transaction = Transaction.new(data, nil)
    assert_equal "4654405418249632", transaction.credit_card_number
  end

  def test_has_a_credit_card_expiration
    transaction = Transaction.new(data, nil)
    assert_equal "", transaction.credit_card_expiration_date
  end

  def test_has_a_result
    transaction = Transaction.new(data, nil)
    assert_equal "success", transaction.result
  end

  def test_has_created_at
    transaction = Transaction.new(data, nil)
    assert_equal "2012-03-27", transaction.created_at
  end

  def test_has_updated_at
    transaction = Transaction.new(data, nil)
    assert_equal "2012-03-27", transaction.updated_at
  end

  def test_invoice_calls_parent
    parent = Minitest::Mock.new
    transaction = Transaction.new(data, parent)
    parent.expect(:find_invoice, nil, [1])
    transaction.invoice
    parent.verify
  end
end
