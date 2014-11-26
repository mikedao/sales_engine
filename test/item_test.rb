require_relative 'test_helper'
require_relative '../lib/item'

class ItemTest < Minitest::Test
# id,name,description,unit_price,merchant_id,created_at,updated_at
# 1,Item Qui Esse,Nihil autem sit odio inventore deleniti. Est laudantium ratione distinctio laborum. Minus voluptatem nesciunt assumenda dicta voluptatum porro.,75107,1,2012-03-27 14:53:59 UTC,2012-03-27 14:53:59 UTC
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
    assert_equal 75107, item.unit_price
  end

  def test_it_has_an_merchant_id
    item = Item.new(data, nil)
    assert_equal 1, item.merchant_id
  end

  def test_it_has_a_created_at_date
    item = Item.new(data, nil)
    assert_equal "2012-03-27 14:53:59 UTC", item.created_at
  end

  def test_it_has_an_updated_at_date
    item = Item.new(data, nil)
    assert_equal "2012-03-27 14:53:59 UTC", item.updated_at
  end
end
