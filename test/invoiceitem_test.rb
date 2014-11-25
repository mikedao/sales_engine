require_relative 'test_helper'
require_relative '../lib/invoiceitem'

class InvoiceItemTest < Minitest::Test
  attr_reader   :data
  #id,item_id,invoice_id,quantity,unit_price,created_at,updated_at
  #1,539,1,5,13635,2012-03-27 14:54:09 UTC,2012-03-27 14:54:09 UTC


  def setup
    @data = {
              id:           1,
              item_id:      539,
              invoice_id:   1,
              quantity:     5,
              unit_price:   13635,
              created_at:   "2012-03-27 14:54:09 UTC",
              updated_at:   "2012-03-27 14:54:09 UTC"
            }
  end

  def test_has_an_id
    invoiceitem = InvoiceItem.new(data)
    assert_equal 1, invoiceitem.id
  end

  def test_has_an_item_id
    invoiceitem = InvoiceItem.new(data)
    assert_equal 539, invoiceitem.item_id
  end

  def test_has_an_invoice_id
    invoiceitem = InvoiceItem.new(data)
    assert_equal 1, invoiceitem.invoice_id
  end

  def test_has_a_quantity
    invoiceitem = InvoiceItem.new(data)
    assert_equal 5, invoiceitem.quantity
  end

  def test_has_a_unit_price
    invoiceitem = InvoiceItem.new(data)
    assert_equal 13635, invoiceitem.unit_price
  end

  def test_has_a_created_at
    invoiceitem = InvoiceItem.new(data)
    assert_equal "2012-03-27 14:54:09 UTC", invoiceitem.created_at
  end

  def test_has_an_updated_at
    invoiceitem = InvoiceItem.new(data)
    assert_equal "2012-03-27 14:54:09 UTC", invoiceitem.updated_at
  end
end
