require_relative 'test_helper'
require_relative '../lib/item'
require_relative '../lib/sales_engine'


class ItemTest < Minitest::Test
  attr_reader :data

  def setup
    @data = {
              id: "1",
              name: "Skateboard",
              description: "Transportation device",
              unit_price: "75107",
              merchant_id: "1",
              created_at: "2012-03-27 14:53:59 UTC",
              updated_at: "2012-03-27 14:53:59 UTC"
            }
  end

  def test_it_has_an_id
    item = Item.new(data, nil)
    assert_equal 1, item.id
  end

  def test_it_has_a_name
    item = Item.new(data, nil)
    assert_equal "Skateboard", item.name
  end

  def test_it_has_an_description
    item = Item.new(data, nil)
    assert_equal "Transportation device", item.description
  end

  def test_it_has_an_unit_price
    item = Item.new(data, nil)
    assert_equal BigDecimal.new("751.07"), item.unit_price
  end

  def test_it_has_an_merchant_id
    item = Item.new(data, nil)
    assert_equal 1, item.merchant_id
  end

  def test_it_has_a_created_at_date
    item = Item.new(data, nil)
    assert_equal "2012-03-27", item.created_at
  end

  def test_it_has_an_updated_at_date
    item = Item.new(data, nil)
    assert_equal "2012-03-27", item.updated_at
  end

  def test_invoice_items_calls_parent
    parent = Minitest::Mock.new
    item = Item.new(data, parent)
    parent.expect(:find_invoice_items, nil, [1])
    item.invoice_items
    parent.verify
  end

  def test_merchant_calls_parent
    parent = Minitest::Mock.new
    item = Item.new(data, parent)
    parent.expect(:find_merchant, nil, [1])
    item.merchant
    parent.verify
  end

  def test_best_day_for_item
    se = SalesEngine.new(nil)
    se.startup
    assert_equal Date.parse("2012-03-10"), se.item_repository.items[2].best_day
  end

  def test_revenue
    se = SalesEngine.new(nil)
    se.startup
    assert_equal BigDecimal.new("29393.91"), se.item_repository.items[2].revenue
  end

end
