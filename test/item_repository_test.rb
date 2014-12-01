require_relative 'test_helper'
require_relative '../lib/item_repository'
require_relative '../lib/item.rb'
require_relative '../lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  attr_reader   :data1,
                :data2,
                :data3,
                :item_repository

  def setup
    @data1 =  {
                id: "1",
                name: "Skateboard",
                description: "Transportation device",
                unit_price: "75107",
                merchant_id: "1",
                created_at: "2012-03-27 14:53:59 UTC",
                updated_at: "2012-03-27 14:53:59 UTC"
              }

    @data2 =  {
                id: "2",
                name: "Apple Pie",
                description: "Nums",
                unit_price: "11111",
                merchant_id: "2",
                created_at: "2012-03-27 14:53:59 UTC",
                updated_at: "2012-03-28 14:53:59 UTC"
              }

    @data3 =  {
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
    @item_repository = ItemRepository.new(nil)
    item_repository << data1
    item_repository << data2
    item_repository << data3
  end

  def test_it_knows_its_parent
    ir = ItemRepository.new(nil)
    ir << data1
    assert_equal ir, ir.data.first.repository
  end

  def test_it_loads_csv_file
    ir = ItemRepository.new(nil)
    assert ir.data.empty?
    ir.csv_loader('./test/fixtures/items_test.csv')
    refute ir.data.empty?
    assert_equal 10, ir.data.count
    assert_equal "31163", ir.data[6].unit_price
  end

  def test_it_starts_empty
    item_repository = ItemRepository.new(nil)
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
    assert_equal "22222", item_repository.data[2].unit_price
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
    result = item_repository.find_by_id("2")
    assert_equal "Apple Pie", result.name
  end

  def test_find_all_by_id
    load_test_data
    result = item_repository.find_all_by_id("7")
    assert_equal "Turkey", result.first.name
  end

  def test_find_by_name
    load_test_data
    result = item_repository.find_by_name("Turkey")
    assert_equal "7", result.id
  end

  def test_find_all_by_name
    load_test_data
    result = item_repository.find_all_by_name("Skateboard")
    assert_equal "1", result.first.id
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
    result = item_repository.find_by_unit_price("75107")
    assert_equal "Skateboard", result.name
  end

  def test_find_all_by_unit_price
    load_test_data
    result = item_repository.find_all_by_unit_price("22222")
    assert_equal "Food", result.last.description
  end

  def test_find_by_merchant_id
    load_test_data
    result = item_repository.find_by_merchant_id("2")
    assert_equal "Nums", result.description
  end

  def test_find_all_merchant_id
    load_test_data
    result = item_repository.find_all_by_merchant_id("2")
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
    assert_equal "7", result.last.id
  end

  def test_it_calls_se_to_find_invoice_items_by_item_id
    parent = Minitest::Mock.new
    ir = ItemRepository.new(parent)
    ir << data1
    ir << data2
    ir << data3
    parent.expect(:find_invoice_items_by_item_id, nil, ["1"])
    ir.find_invoice_items(ir.data.first.id)
    parent.verify
  end

  def test_find_merchant_calls_se
    parent = Minitest::Mock.new
    ir = ItemRepository.new(parent)
    ir << data1
    ir << data2
    ir << data3
    parent.expect(:find_merchant_by_id, nil, ["1"])
    ir.find_merchant(ir.data.first.id)
  end

  def test_top_items_by_revenue
    se = SalesEngine.new
    se.startup
    result = se.itemrepository.most_revenue(5)
    assert 5, result.size
    assert result.is_a?(Array)
    assert result[0].is_a?(Item)
    assert_equal "Item Dicta Autem", result[0].name
  end

  def test_top_items_by_quantity_sold
    se = SalesEngine.new
    se.startup
    result = se.itemrepository.most_items(5)
    assert 5, result.size
    assert result.is_a?(Array)
    assert result[0].is_a?(Item)
    assert_equal "Item Dicta Autem", result[0].name
  end

end
