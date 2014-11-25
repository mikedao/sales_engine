require_relative 'test_helper'
require_relative '../lib/invoiceitem_repository'
require_relative '../lib/invoiceitem'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader   :data1,
                :data2,
                :data3

  def setup
    @data1 = {
      id:           "1",
      item_id:      "539",
      invoice_id:   "1",
      quantity:     "5",
      unit_price:   "13635",
      created_at:   "2012-03-27 14:54:09 UTC",
      updated_at:   "2012-03-27 14:54:09 UTC"
    }
    @data2 = {
      id:           "2",
      item_id:      "600",
      invoice_id:   "2",
      quantity:     "8",
      unit_price:   "13735",
      created_at:   "2012-03-27 14:54:10 UTC",
      updated_at:   "2012-03-27 14:54:10 UTC"
    }
    @data3 = {
      id:           "3",
      item_id:      "666",
      invoice_id:   "2",
      quantity:     "8",
      unit_price:   "87768",
      created_at:   "2014-03-27 14:54:09 UTC",
      updated_at:   "2014-03-27 14:54:09 UTC"
    }
  end

  def test_it_starts_empty
    invoiceitemrepository = InvoiceItemRepository.new
    assert invoiceitemrepository.data.empty?
  end

  def test_it_has_merchants
    invoiceitemrepository = InvoiceItemRepository.new
    invoiceitemrepository << InvoiceItem.new(data1)
    invoiceitemrepository << InvoiceItem.new(data2)
    invoiceitemrepository << InvoiceItem.new(data3)
    refute invoiceitemrepository.data.empty?
  end

  def test_it_has_three_merchants
    invoiceitemrepository = InvoiceItemRepository.new
    invoiceitemrepository << InvoiceItem.new(data1)
    invoiceitemrepository << InvoiceItem.new(data2)
    invoiceitemrepository << InvoiceItem.new(data3)
    assert_equal 3, invoiceitemrepository.data.size
  end

  def test_it_can_access_individual_merchants
    invoiceitemrepository = InvoiceItemRepository.new
    invoiceitemrepository << InvoiceItem.new(data1)
    invoiceitemrepository << InvoiceItem.new(data2)
    invoiceitemrepository << InvoiceItem.new(data3)
    assert_equal 87768, invoiceitemrepository.data[2].unit_price
  end


end
