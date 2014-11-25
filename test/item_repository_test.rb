require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/item.rb'

class ItemRepositoryTest < Minitest::Test
  attr_reader   :data1,
                :data2,
                :data3

  def setup
    @data1 = {
      id: "1",
      name: "Skateboard",
      description: "Transportation device",
      unit_price: "75107",
      merchant_id: "1",
      created_at: "2012-03-27 14:53:59 UTC",
      updated_at: "2012-03-27 14:53:59 UTC"
    }

    @data2 = {
      id: "2",
      name: "Apple Pie",
      description: "Nums",
      unit_price: "11111",
      merchant_id: "2",
      created_at: "2012-03-28 14:53:59 UTC",
      updated_at: "2012-03-28 14:53:59 UTC"
    }

    @data3 = {
      id: "7",
      name: "Turkey",
      description: "Food",
      unit_price: "22222",
      merchant_id: "2",
      created_at: "2012-03-29 14:53:59 UTC",
      updated_at: "2012-03-29 14:53:59 UTC"
    }
  end

  def test_it_has_items
    itemrepository = ItemRepository.new
    itemrepository << Item.new(data1)
    itemrepository << Item.new(data2)
    itemrepository << Item.new(data3)
    refute itemrepository.data.empty?
  end

  def test_it_has_three_items
    itemrepository = ItemRepository.new
    itemrepository << Item.new(data1)
    itemrepository << Item.new(data2)
    itemrepository << Item.new(data3)
    assert_equal 3, itemrepository.data.size
  end

  def test_it_can_access_individual_items
    itemrepository = ItemRepository.new
    itemrepository << Item.new(data1)
    itemrepository << Item.new(data2)
    itemrepository << Item.new(data3)
    assert_equal 22222, itemrepository.data[2].unit_price
  end

end
