require_relative 'test_helper'
require_relative '../lib/merchant'
require_relative '../lib/sales_engine'

class MerchantTest < Minitest::Test
  attr_accessor :data

  def setup
    @data = { id: "1",
              name: "Schroeder-Jerde",
              created_at: "2012-03-27 14:53:59 UTC",
              updated_at: "2012-03-27 14:53:59 UTC"
            }
  end



  def test_it_has_an_id
    merchant = Merchant.new(data, nil)
    assert_equal 1, merchant.id
  end

  def test_it_has_a_name
    merchant = Merchant.new(data, nil)
    assert_equal "Schroeder-Jerde", merchant.name
  end

  def test_it_has_a_created_at
    merchant = Merchant.new(data, nil)
    assert_equal "2012-03-27", merchant.created_at
  end

  def test_it_has_a_updated_at
    merchant = Merchant.new(data, nil)
    assert_equal "2012-03-27", merchant.updated_at
  end

  def test_items_calls_parent
    parent = Minitest::Mock.new
    merchant = Merchant.new(data, parent)
    parent.expect(:find_items, nil, [1])
    merchant.items
    parent.verify
  end

  def test_invoices_calls_parent
    parent = Minitest::Mock.new
    merchant = Merchant.new(data, parent)
    parent.expect(:find_invoices, nil, [1])
    merchant.invoices
    parent.verify
  end


  def test_revenue
    skip
    se = SalesEngine.new(nil)
    se.startup
    assert_equal BigDecimal(33805554)/100, se.merchant_repository.merchants[2].revenue
    assert_equal BigDecimal(1281794)/100, se.merchant_repository.merchants[0].revenue("2012-03-25")
  end

  def test_favorite_customer
    se = SalesEngine.new(nil)
    se.startup
    assert_equal 63, se.merchant_repository.merchants[3].transactions.size
    assert_equal 'Kuhn', se.merchant_repository.merchants[50].favorite_customer.last_name
  end

  def test_customers_with_pending_invoices
    se = SalesEngine.new(nil)
    se.startup
    assert_equal 2, se.merchant_repository.merchants[33].customers_with_pending_invoices.size
  end

  def test_items_sold
    se = SalesEngine.new(nil)
    se.startup
    assert_equal 1064, se.merchant_repository.merchants[87].items_sold
  end
end
