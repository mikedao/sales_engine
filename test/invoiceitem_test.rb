require_relative 'test_helper'
require_relative '../lib/invoiceitem'

class InvoiceItemTest < Minitest::Test
  attr_reader   :data

  def setup
    @data = {
              id:           "1",
              item_id:      "539",
              invoice_id:   "1",
              quantity:     "5",
              unit_price:   "13635",
              created_at:   "2012-03-27 14:54:09 UTC",
              updated_at:   "2012-03-27 14:54:09 UTC"
            }
  end

  def test_has_an_id
    invoiceitem = InvoiceItem.new(data, nil)
    assert_equal 1, invoiceitem.id
  end

  def test_has_an_item_id
    invoiceitem = InvoiceItem.new(data, nil)
    assert_equal 539, invoiceitem.item_id
  end

  def test_has_an_invoice_id
    invoiceitem = InvoiceItem.new(data, nil)
    assert_equal 1, invoiceitem.invoice_id
  end

  def test_has_a_quantity
    invoiceitem = InvoiceItem.new(data, nil)
    assert_equal 5, invoiceitem.quantity
  end

  def test_has_a_unit_price
    invoiceitem = InvoiceItem.new(data, nil)
    assert_equal BigDecimal.new("136.35"), invoiceitem.unit_price
  end

  def test_has_a_created_at
    invoiceitem = InvoiceItem.new(data, nil)
    assert_equal "2012-03-27", invoiceitem.created_at
  end

  def test_has_an_updated_at
    invoiceitem = InvoiceItem.new(data, nil)
    assert_equal "2012-03-27", invoiceitem.updated_at
  end

  def test_invoice_calls_parent
    parent = Minitest::Mock.new
    invoiceitem = InvoiceItem.new(data, parent)
    parent.expect(:find_invoice, nil, [1])
    invoiceitem.invoice
    parent.verify
  end

  def test_item_calls_parent
    parent = Minitest::Mock.new
    invoiceitem = InvoiceItem.new(data, parent)
    parent.expect(:find_item, nil, [539])
    invoiceitem.item
    parent.verify
  end

end
