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
    invoice = Invoice.new(data, self)

    assert_equal 1, invoice.id
  end

  def test_it_has_a_customer_id
    invoice = Invoice.new(data)

    assert_equal 1, invoice.customer_id
  end

  def test_it_has_a_merchant_id
    invoice = Invoice.new(data)

    assert_equal 26, invoice.merchant_id
  end

  def test_it_has_a_status
    invoice = Invoice.new(data)

    assert_equal "shipped", invoice.status
  end

  def test_it_has_a_created_at_date
    invoice = Invoice.new(data)

    assert_equal "2012-03-25 09:54:09 UTC", invoice.created_at
  end

  def test_it_has_an_updated_at_date
    invoice = Invoice.new(data)

    assert_equal "2012-03-25 09:54:09 UTC", invoice.updated_at
  end
end
