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
      assert 26, se.find_items_by_merchant_id("3").size

    end




end
