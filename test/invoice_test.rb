require_relative 'test_helper'
require_relative '../lib/invoice'

class InvoiceTest < Minitest::Test
#id,customer_id,merchant_id,status,created_at,updated_at
#1,1,26,shipped,2012-03-25 09:54:09 UTC,2012-03-25 09:54:09 UTC
  attr_reader :data

  def setup
    @data = {
              id:          "1",
              customer_id: "1",
              merchant_id: "26",
              status:      "shipped",
              created_at:  "2012-03-25 09:54:09 UTC",
              updated_at:  "2012-03-25 09:54:09 UTC"
            }
  end

  def test_it_has_an_id
    invoice = Invoice.new(data, nil)

    assert_equal "1", invoice.id
  end

  def test_it_has_a_customer_id
    invoice = Invoice.new(data, nil)

    assert_equal "1", invoice.customer_id
  end

  def test_it_has_a_merchant_id
    invoice = Invoice.new(data, nil)

    assert_equal "26", invoice.merchant_id
  end

  def test_it_has_a_status
    invoice = Invoice.new(data, nil)

    assert_equal "shipped", invoice.status
  end

  def test_it_has_a_created_at_date
    invoice = Invoice.new(data, nil)

    assert_equal "2012-03-25 09:54:09 UTC", invoice.created_at
  end

  def test_it_has_an_updated_at_date
    invoice = Invoice.new(data, nil)

    assert_equal "2012-03-25 09:54:09 UTC", invoice.updated_at
  end

  def test_transactions_calls_parent
    parent = Minitest::Mock.new
    invoice = Invoice.new(data, parent)
    parent.expect(:find_transactions, nil, ["1"])
    invoice.transactions
    parent.verify
  end

  def test_invoice_items_calls_parent
    parent = Minitest::Mock.new
    invoice = Invoice.new(data, parent)
    parent.expect(:find_invoice_items, nil, ["1"])
    invoice.invoice_items
    parent.verify
  end

  def test_customer_calls_parent
    parent = Minitest::Mock.new
    invoice = Invoice.new(data, parent)
    parent.expect(:find_customer, nil, ["1"])
    invoice.customer
    parent.verify
  end

  def test_merchant_calls_parent
    parent = Minitest::Mock.new
    invoice = Invoice.new(data, parent)
    parent.expect(:find_merchant, nil, ["26"])
    invoice.merchant
    parent.verify
  end
end
