require_relative 'test_helper'
require_relative '../lib/sales_engine'

class SalesEngineTest < Minitest::Test
    attr_reader :se

    def setup
      @se = SalesEngine.new(nil)
      se.startup
    end

    def test_sales_engine_exists
      assert se
    end

    def test_startup_initializes_repos
      assert se.customer_repository
      assert se.invoice_repository
      assert se.invoice_item_repository
      assert se.item_repository
      assert se.merchant_repository
      assert se.transaction_repository
    end


    def test_startup_loads_repo_data
      refute se.customer_repository.customers.empty?
      assert se.customer_repository.customers[0].is_a?(Customer)

      refute se.invoice_repository.invoices.empty?
      assert se.invoice_repository.invoices[0].is_a?(Invoice)

      refute se.invoice_item_repository.invoice_items.empty?
      assert se.invoice_item_repository.invoice_items[0].is_a?(InvoiceItem)

      refute se.item_repository.items.empty?
      assert se.item_repository.items[0].is_a?(Item)

      refute se.merchant_repository.merchants.empty?
      assert se.merchant_repository.merchants[0].is_a?(Merchant)

      refute se.transaction_repository.transactions.empty?
      assert se.transaction_repository.transactions[0].is_a?(Transaction)
    end

    def test_find_items_by_merchant_id
      refute se.find_items_by_merchant_id(3).empty?
      assert_equal BigDecimal.new("775.96"), se.find_items_by_merchant_id(3)[0].unit_price
      assert_equal 26, se.find_items_by_merchant_id(3).size
    end

    def test_find_invoices_by_merchant_id
      refute se.find_invoices_by_merchant_id(3).empty?
      assert_equal 17, se.find_invoices_by_merchant_id(3)[0].customer_id
      assert_equal 43, se.find_invoices_by_merchant_id(3).size
    end

    def test_find_invoices_by_customer_id
      refute se.find_invoices_by_customer_id(7).empty?
      assert_equal 86, se.find_invoices_by_customer_id(3)[0].merchant_id
      assert_equal 4, se.find_invoices_by_customer_id(3).size
    end


    def test_find_transactions_by_invoice_id
      refute se.find_transactions_by_invoice_id(4).empty?
      assert_equal "4354495077693036", se.find_transactions_by_invoice_id(4)[0].credit_card_number
      assert_equal 1, se.find_transactions_by_invoice_id(4).size
    end

    def test_find_invoice_items_by_invoice_id
      refute se.find_invoice_items_by_invoice_id(1).empty?
      assert_equal 539, se.find_invoice_items_by_invoice_id(1)[0].item_id
      assert_equal 2, se.find_invoice_items_by_invoice_id(4).size
    end

    def test_find_customer_by_id
      refute se.find_customer_by_id(1).nil?
      assert_equal "Joey", se.find_customer_by_id(1).first_name
    end

    def test_find_invoice_items_by_item_id
      refute se.find_invoice_items_by_item_id(1).empty?
      assert_equal 3, se.find_invoice_items_by_item_id(535)[0].quantity
    end

    def test_find_merchant_by_id
      refute se.find_merchant_by_id(26).nil?
      assert_equal "Balistreri, Schaefer and Kshlerin", se.find_merchant_by_id(26).name
    end

    def test_find_invoice_by_id
      refute se.find_invoice_by_id(26).nil?
      assert_equal 7, se.find_invoice_by_id(26).customer_id
    end

    def test_find_item_by_id
      refute se.find_item_by_id(26).nil?
      assert_equal "Item Non Deserunt", se.find_item_by_id(26).name
    end

    def test_find_successful_transactions_by_invoice_id
      refute se.find_successful_transactions_by_invoice_id(23).nil?
      assert_equal "success", se.find_successful_transactions_by_invoice_id(23)[0].result
    end


end
