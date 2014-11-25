require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader   :data1,
                :data2,
                :data3,
                :invoice_repository

  def setup
    @data1 = {
      id:          "1",
      customer_id: "2",
      merchant_id: "26",
      status:      "failed",
      created_at:  "2012-03-25 09:54:09 UTC",
      updated_at:  "2012-03-25 09:54:09 UTC"
    }

    @data2 = {
      id:          "2",
      customer_id: "2",
      merchant_id: "29",
      status:      "shipped",
      created_at:  "2013-03-25 12:54:12 UTC",
      updated_at:  "2013-03-25 12:54:12 UTC"
    }

    @data3 = {
      id:          "3",
      customer_id: "4",
      merchant_id: "26",
      status:      "shipped",
      created_at:  "2012-03-25 09:54:09 UTC",
      updated_at:  "2012-03-25 09:54:09 UTC"
    }
  end

  def load_data
    @invoice_repository = InvoiceRepository.new
    invoice_repository << Invoice.new(data1)
    invoice_repository << Invoice.new(data2)
    invoice_repository << Invoice.new(data3)
  end

  def test_it_starts_empty
    invoice_repository = InvoiceRepository.new
    assert invoice_repository.data.empty?
  end

  def test_it_has_invoices
    load_data
    refute invoice_repository.data.empty?
  end

  def test_it_has_three_invoices
    load_data
    assert_equal 3, invoice_repository.data.size
  end

  def test_it_can_access_individual_invoices
    load_data
    assert_equal "shipped", invoice_repository.data[2].status
  end

  def test_it_returns_all_invoices
    load_data
    assert_equal 3, invoice_repository.all.size
    assert_equal invoice_repository.data, invoice_repository.all
  end

  def test_it_returns_one_random_invoice
    load_data
    assert invoice_repository.random.is_a?(Invoice)
    refute invoice_repository.random.is_a?(Array)
  end

  def test_it_finds_by_id
    load_data
    result = invoice_repository.find_by_id(2)
    assert_equal 29, result.merchant_id
  end

  def test_it_finds_all_by_id
    load_data
    result = invoice_repository.find_all_by_id(3)
    assert_equal 26, result.first.merchant_id
  end

  def test_it_finds_by_customer_id
    load_data
    result = invoice_repository.find_by_customer_id(2)
    assert_equal "failed", result.status
  end

  def test_it_finds_all_by_customer_id
    load_data
    result = invoice_repository.find_all_by_customer_id(2)
    assert_equal 2, result.size
    e1, e2 = result
    assert_equal 1, e1.id
    assert_equal 2, e2.id
  end

  def test_it_finds_by_merchant_id
    load_data
    result = invoice_repository.find_by_merchant_id(29)
    assert_equal 2, result.customer_id
  end

  def test_it_finds_all_by_merchant_id
    load_data
    result = invoice_repository.find_all_by_merchant_id(26)
    assert_equal 2, result.size
    e1, e2 = result
    assert_equal 1, e1.id
    assert_equal 3, e2.id
  end

  def test_it_finds_by_status
    load_data
    result = invoice_repository.find_by_status("shipped")
    assert_equal 29, result.merchant_id
  end

  def test_it_finds_all_by_status
    load_data
    result = invoice_repository.find_all_by_status("shipped")
    assert_equal 2, result.size
    e1, e2 = result
    assert_equal 29, e1.merchant_id
    assert_equal 26, e2.merchant_id
  end

  def test_it_finds_by_created_at_date
    load_data
    result = invoice_repository.find_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal "failed", result.status
  end

  def test_it_finds_all_by_created_at_date
    load_data
    result = invoice_repository.find_all_by_created_at("2012-03-25 09:54:09 UTC")
    assert_equal 2, result.size
    e1, e2 = result
    assert_equal 1, e1.id
    assert_equal 3, e2.id
  end

  def test_it_finds_by_updated_at_date
    load_data
    result = invoice_repository.find_by_updated_at("2012-03-25 09:54:09 UTC")
    assert_equal "failed", result.status
  end

  def test_it_finds_all_by_updated_at_date
    load_data
    result = invoice_repository.find_all_by_updated_at("2012-03-25 09:54:09 UTC")
    assert_equal 2, result.size
    e1, e2 = result
    assert_equal 1, e1.id
    assert_equal 3, e2.id
  end

end
