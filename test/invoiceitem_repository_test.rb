require_relative 'test_helper'
require_relative '../lib/invoiceitem_repository'
require_relative '../lib/invoiceitem'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader   :data1,
                :data2,
                :data3,
                :invoiceitemrepository

  def setup
    @data1 =  {
                id:           "1",
                item_id:      "539",
                invoice_id:   "1",
                quantity:     "5",
                unit_price:   "13735",
                created_at:   "2012-03-27 14:54:09 UTC",
                updated_at:   "2012-03-27 14:54:09 UTC"
              }

    @data2 =  {
                id:           "2",
                item_id:      "666",
                invoice_id:   "2",
                quantity:     "8",
                unit_price:   "13735",
                created_at:   "2012-03-27 14:54:09 UTC",
                updated_at:   "2012-03-27 14:54:09 UTC"
              }

    @data3 =  {
                id:           "3",
                item_id:      "666",
                invoice_id:   "2",
                quantity:     "8",
                unit_price:   "87768",
                created_at:   "2014-03-27 14:54:09 UTC",
                updated_at:   "2014-03-27 14:54:09 UTC"
              }
  end

  def load_test_data
    @invoiceitemrepository = InvoiceItemRepository.new(nil)
    invoiceitemrepository << data1
    invoiceitemrepository << data2
    invoiceitemrepository << data3
  end

  def test_it_starts_empty
    invoiceitemrepository = InvoiceItemRepository.new(nil)
    assert invoiceitemrepository.invoice_items.empty?
  end

  def test_it_knows_its_parent
    iir = InvoiceItemRepository.new(nil)
    iir << data1
    assert iir, iir.invoice_items.first.repository
  end


  def test_it_has_invoice_items
    load_test_data
    refute invoiceitemrepository.invoice_items.empty?
  end

  def test_it_has_three_invoice_items
    load_test_data
    assert_equal 3, invoiceitemrepository.invoice_items.size
  end

  def test_it_can_access_individual_invoice_items
    load_test_data
    assert_equal BigDecimal.new("877.68"), invoiceitemrepository.invoice_items[2].unit_price
  end

  def test_it_can_return_all_invoiceitems
    load_test_data
    assert_equal 3, invoiceitemrepository.all.size
    assert_equal invoiceitemrepository.invoice_items, invoiceitemrepository.all
  end

  def test_it_can_return_random_invoiceitem
    load_test_data
    assert invoiceitemrepository.random.is_a?(InvoiceItem)
    refute invoiceitemrepository.random.is_a?(Array)
  end

  def test_it_can_find_by_id
    load_test_data
    result = invoiceitemrepository.find_by_id(1)
    assert_equal 539, result.item_id
  end

  def test_it_can_find_all_by_id
    load_test_data
    result = invoiceitemrepository.find_all_by_id(3)
    assert_equal 666, result.first.item_id
  end

  def test_it_can_find_by_item_id
    load_test_data
    result = invoiceitemrepository.find_by_item_id(539)
    assert_equal 5, result.quantity
  end

  def test_it_can_find_all_by_item_id
    load_test_data
    result = invoiceitemrepository.find_all_by_item_id(666)
    assert_equal 2, result.size
    e1, e2 = result
    assert_equal 2, e1.id
    assert_equal 3, e2.id
  end

  def test_it_can_find_by_invoice_id
    load_test_data
    result = invoiceitemrepository.find_by_invoice_id(2)
    assert_equal BigDecimal.new("137.35"), result.unit_price
  end

  def test_it_can_find_all_by_invoice_id
    load_test_data
    result = invoiceitemrepository.find_all_by_invoice_id(2)
    assert_equal 2, result.size
    e1, e2 = result
    assert_equal 2, e1.id
    assert_equal 3, e2.id
  end

  def test_it_can_find_by_quantity
    load_test_data
    result = invoiceitemrepository.find_by_quantity(5)
    assert_equal 1, result.id
  end

  def test_it_can_find_all_by_quantity
    load_test_data
    result = invoiceitemrepository.find_all_by_quantity(5)
    assert_equal 1, result.size
    assert_equal BigDecimal.new("137.35"), result[0].unit_price

  end

  def test_it_can_find_by_unit_price
    load_test_data
    result = invoiceitemrepository.find_by_unit_price(BigDecimal.new("137.35"))
    assert_equal 1, result.id
  end

  def test_it_can_find_all_by_unit_price
    load_test_data
    result = invoiceitemrepository.find_all_by_unit_price(BigDecimal.new("137.35"))
    assert_equal 2, result.size
    e1, e2 = result
    assert_equal 539, e1.item_id
    assert_equal 666, e2.item_id
  end

  def test_it_can_find_by_created_at_date
    load_test_data
    result = invoiceitemrepository.find_by_created_at("2012-03-27")
    assert_equal 1, result.id
  end

  def test_it_can_find_all_by_created_at_date
    load_test_data
    result = invoiceitemrepository.find_all_by_created_at("2012-03-27")
    assert_equal 2, result.size
    e1, e2 = result
    assert_equal 5, e1.quantity
    assert_equal 8, e2.quantity
  end

  def test_it_can_find_by_updated_at_date
    load_test_data
    result = invoiceitemrepository.find_by_updated_at("2014-03-27")
    assert_equal 3, result.id
  end

  def test_it_can_find_all_by_updated_at_date
    load_test_data
    result = invoiceitemrepository.find_all_by_updated_at("2012-03-27")
    assert_equal 2, result.size
    e1, e2 = result
    assert_equal 5, e1.quantity
    assert_equal 8, e2.quantity
  end

  def test_find_invoice_calls_sales_engine
    parent = Minitest::Mock.new
    iir = InvoiceItemRepository.new(parent)
    iir << data1
    iir << data2
    iir << data3
    parent.expect(:find_invoice_by_id, nil, [1])
    iir.find_invoice(iir.invoice_items.first.invoice_id)
  end

  def test_find_item_calls_sales_engine
    parent = Minitest::Mock.new
    iir = InvoiceItemRepository.new(parent)
    iir << data1
    iir << data2
    iir << data3
    parent.expect(:find_item_by_id, nil, [539])
    iir.find_item(iir.invoice_items.first.item_id)
  end

end
