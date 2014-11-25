require_relative 'test_helper'
require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader   :data1,
                :data2,
                :data3

  def setup
    @data1 = {
      id:          "1",
      customer_id: "1",
      merchant_id: "26",
      status:      "shipped",
      created_at:  "2012-03-25 09:54:09 UTC",
      updated_at:  "2012-03-25 09:54:09 UTC"
    }

    @data2 = {
      id:          "2",
      customer_id: "2",
      merchant_id: "29",
      status:      "shipped",
      created_at:  "2012-03-25 12:54:12 UTC",
      updated_at:  "2012-03-25 12:54:12 UTC"
    }

    @data3 = {
      id:          "3",
      customer_id: "4",
      merchant_id: "85",
      status:      "shipped",
      created_at:  "2012-03-25 09:54:10 UTC",
      updated_at:  "2012-03-25 10:54:09 UTC"
    }
  end

  def test_it_starts_empty
    invoice_repository = InvoiceRepository.new
    assert invoice_repository.data.empty?
  end

  def test_it_has_invoices
    invoice_repository = InvoiceRepository.new
    invoice_repository << Invoice.new(data1)
    invoice_repository << Invoice.new(data2)
    invoice_repository << Invoice.new(data3)
    refute invoice_repository.data.empty?
  end

  def test_it_has_three_invoices
    invoice_repository = InvoiceRepository.new
    invoice_repository << Invoice.new(data1)
    invoice_repository << Invoice.new(data2)
    invoice_repository << Invoice.new(data3)
    assert_equal 3, invoice_repository.data.size
  end

  def test_it_can_access_individual_invoices
    invoice_repository = InvoiceRepository.new
    invoice_repository << Invoice.new(data1)
    invoice_repository << Invoice.new(data2)
    invoice_repository << Invoice.new(data3)
    assert_equal "shipped", invoice_repository.data[2].status
  end


end
