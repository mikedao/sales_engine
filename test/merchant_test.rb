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
    assert_equal "1", merchant.id
  end

  def test_it_has_a_name
    merchant = Merchant.new(data, nil)
    assert_equal "Schroeder-Jerde", merchant.name
  end

  def test_it_has_a_created_at
    merchant = Merchant.new(data, nil)
    assert_equal "2012-03-27 14:53:59 UTC", merchant.created_at
  end

  def test_it_has_a_updated_at
    merchant = Merchant.new(data, nil)
    assert_equal "2012-03-27 14:53:59 UTC", merchant.updated_at
  end

  def test_items_calls_parent
    parent = Minitest::Mock.new
    merchant = Merchant.new(data, parent)
    parent.expect(:find_items, nil, ["1"])
    merchant.items
    parent.verify
  end

  def test_invoices_calls_parent
    parent = Minitest::Mock.new
    merchant = Merchant.new(data, parent)
    parent.expect(:find_invoices, nil, ["1"])
    merchant.invoices
    parent.verify
  end

  def test_revenue
    se = SalesEngine.new
    se.startup
    assert_equal 33805554, se.merchantrepository.data[2].revenue
    assert_equal 1281794, se.merchantrepository.data[0].revenue("2012-03-25 13:54:11 UTC")
  end

end
