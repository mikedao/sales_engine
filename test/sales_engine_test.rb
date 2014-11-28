require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
    attr_reader :se

    def setup
      @se = SalesEngine.new
      se.startup
    end

    def test_sales_engine_exists
      assert se
    end

    def test_startup_initializes_repos
      assert se.customerrepository
      assert se.invoicerepository
      assert se.invoiceitemrepository
      assert se.itemrepository
      assert se.merchantrepository
      assert se.transactionrepository
    end


    def test_startup_loads_repo_data
      refute se.customerrepository.data.empty?
      assert se.customerrepository.data[0].is_a?(Customer)

      refute se.invoicerepository.data.empty?
      assert se.invoicerepository.data[0].is_a?(Invoice)

      refute se.invoiceitemrepository.data.empty?
      assert se.invoiceitemrepository.data[0].is_a?(InvoiceItem)

      refute se.itemrepository.data.empty?
      assert se.itemrepository.data[0].is_a?(Item)

      refute se.merchantrepository.data.empty?
      assert se.merchantrepository.data[0].is_a?(Merchant)

      refute se.transactionrepository.data.empty?
      assert se.transactionrepository.data[0].is_a?(Transaction)
    end

    def test_find_items_by_merchant_id
      refute se.find_items_by_merchant_id("3").empty?
      assert_equal "77596", se.find_items_by_merchant_id("3")[0].unit_price
      assert_equal 26, se.find_items_by_merchant_id("3").size
    end

    def test_find_invoices_by_merchant_id
      refute se.find_invoices_by_merchant_id("3").empty?
      assert_equal "17", se.find_invoices_by_merchant_id("3")[0].customer_id
      assert_equal 43, se.find_invoices_by_merchant_id("3").size
    end

    def test_find_invoices_by_customer_id
      refute se.find_invoices_by_customer_id("7").empty?
      assert_equal "86", se.find_invoices_by_customer_id("3")[0].merchant_id
      assert_equal 4, se.find_invoices_by_customer_id("3").size
    end


    def test_find_transactions_by_invoice_id
      refute se.find_transactions_by_invoice_id("4").empty?
      assert_equal "4354495077693036", se.find_transactions_by_invoice_id("4")[0].credit_card_number
      assert_equal 1, se.find_transactions_by_invoice_id("4").size
    end

    def test_find_invoice_items_by_invoice_id
      refute se.find_invoice_items_by_invoice_id("1").empty?
      assert_equal "539", se.find_invoice_items_by_invoice_id("1")[0].item_id
      assert_equal 2, se.find_invoice_items_by_invoice_id("4").size
    end

    def test_find_customer_by_invoice_id
      refute se.find_customer_by_id("1").empty?
      assert_equal "Joey", se.find_customer_by_id("1")[0].first_name
      assert_equal 1, se.find_customer_by_id("4").size
    end

    def test_find_invoice_items_by_item_id
      refute se.find_invoice_items_by_item_id("1").empty?
      assert_equal "3", se.find_invoice_items_by_item_id("535")[0].quantity
    end
end
