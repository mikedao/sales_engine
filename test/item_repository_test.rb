require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/item.rb'

class ItemRepositoryTest < Minitest::Test
  attr_reader   :data1,
                :data2,
                :data3,
                :item_repository

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
      created_at: "2012-03-27 14:53:59 UTC",
      updated_at: "2012-03-28 14:53:59 UTC"
    }

    @data3 = {
      id: "7",
      name: "Turkey",
      description: "Food",
      unit_price: "22222",
      merchant_id: "2",
      created_at: "2012-03-29 14:53:59 UTC",
      updated_at: "2012-03-28 14:53:59 UTC"
    }
  end

  def load_test_data
    @item_repository = ItemRepository.new
    item_repository << Item.new(data1)
    item_repository << Item.new(data2)
    item_repository << Item.new(data3)
  end

  def test_it_starts_empty
    item_repository = ItemRepository.new
    assert item_repository.data.empty?
  end

  def test_it_has_items
    load_test_data
    refute item_repository.data.empty?
  end

  def test_it_has_three_items
    load_test_data
    assert_equal 3, item_repository.data.size
  end

  def test_it_can_access_individual_items
    load_test_data
    assert_equal 22222, item_repository.data[2].unit_price
  end

  def test_all_method_returns_all_items
    load_test_data
    refute item_repository.all.empty?
    assert_equal 3, item_repository.all.size
    assert_equal item_repository.data, item_repository.all
  end

  def test_all_returns_array
    load_test_data
    assert item_repository.all.is_a?(Array)
  end

  def test_random_returns_one_item
    load_test_data
    assert item_repository.random.is_a?(Item)
  end

  def test_random_does_not_return_array_of_merchants
    load_test_data
    refute item_repository.random.is_a?(Array)
  end

  def test_find_by_id
    load_test_data
    result = item_repository.find_by_id(2)
    assert_equal "Apple Pie", result.name
  end

  def test_find_all_by_id
    load_test_data
    result = item_repository.find_all_by_id(7)
    assert_equal "Turkey", result.first.name
  end

  def test_find_by_name
    load_test_data
    result = item_repository.find_by_name("Turkey")
    assert_equal 7, result.id
  end

  def test_find_all_by_name
    load_test_data
    result = item_repository.find_all_by_name("Skateboard")
    assert_equal 1, result.first.id
  end

  def test_find_by_description
    load_test_data
    result = item_repository.find_by_description("Food")
    assert_equal "Turkey", result.name
  end

  def test_find_all_by_description
    load_test_data
    result = item_repository.find_all_by_description("Nums")
    assert_equal "Apple Pie", result.first.name
  end

  def test_find_by_unit_price
    load_test_data
    result = item_repository.find_by_unit_price(75107)
    assert_equal "Skateboard", result.name
  end

  def test_find_all_by_unit_price
    load_test_data
    result = item_repository.find_all_by_unit_price(22222)
    assert_equal "Food", result.last.description
  end

  def test_find_by_merchant_id
    load_test_data
    result = item_repository.find_by_merchant_id(2)
    assert_equal "Nums", result.description
  end

  def test_find_all_merchant_id
    load_test_data
    result = item_repository.find_all_by_merchant_id(2)
    assert_equal 2, result.size
    assert_equal "Turkey", result.last.name
  end

  def test_find_by_created_at
    load_test_data
    result = item_repository.find_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal "Skateboard", result.name
  end

  def test_find_all_by_created_at
    load_test_data
    result = item_repository.find_all_by_created_at("2012-03-27 14:53:59 UTC")
    assert_equal 2, result.size
    assert_equal "Apple Pie", result.last.name
  end

  def test_find_by_updated_at
    load_test_data
    result = item_repository.find_by_updated_at("2012-03-28 14:53:59 UTC")
    assert_equal "Apple Pie", result.name
  end

  def test_find_all_by_updated_at
    load_test_data
    result = item_repository.find_all_by_updated_at("2012-03-28 14:53:59 UTC")
    assert_equal 2, result.size
    assert_equal 7, result.last.id
  end

end
