require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :data1,
              :data2,
              :data3,
              :customer_repository

  def setup
    @data1 = { id:         "1",
               first_name: "Joey",
               last_name:  "Ondricka",
               created_at: "2012-03-27 14:54:09 UTC",
               updated_at: "2012-03-27 14:54:09 UTC"
             }

    @data2 = { id:         "2",
               first_name: "Joey",
               last_name:  "Landers",
               created_at: "2012-04-27 14:54:09 UTC",
               updated_at: "2012-04-27 14:54:09 UTC"
             }

    @data3 = { id:         "3",
               first_name: "Mary",
               last_name:  "Ondricka",
               created_at: "2012-03-27 14:54:09 UTC",
               updated_at: "2012-03-27 14:54:09 UTC"
             }
  end

  def load_test_data
    @customer_repository = CustomerRepository.new
    customer_repository << data1
    customer_repository << data2
    customer_repository << data3
  end

  def test_it_loads_csv_file
    cr = CustomerRepository.new
    assert cr.data.empty?
    cr.csv_loader('./fixtures/customers_test.csv')
    refute cr.data.empty?
    assert_equal 10, cr.data.count
    assert_equal "Parker", cr.data[6].first_name
  end

  def test_it_starts_empty
    customer_repository = CustomerRepository.new
    assert customer_repository.data.empty?
  end

  def test_it_knows_its_parents
    cr = CustomerRepository.new
    cr << data1
    assert_equal cr, cr.data.first.repository
  end

  def test_it_has_customers
    load_test_data
    assert_equal 3, customer_repository.data.size
  end

  def test_it_can_access_individual_customers
    load_test_data
    assert_equal "Landers", customer_repository.data[1].last_name
  end

  def test_all_returns_empty_when_no_data_loaded
    customer_repository = CustomerRepository.new
    assert customer_repository.all.empty?
  end

  def test_all_method_returns_customers
    load_test_data
    assert_equal 3, customer_repository.all.size
    assert_equal customer_repository.data, customer_repository.all
  end

  def test_random_returns_a_single_customer
    load_test_data
    assert customer_repository.random.is_a?(Customer)
  end

  def test_random_does_not_return_an_array_of_customers
    load_test_data
    refute customer_repository.random.is_a?(Array)
  end

  def test_find_by_id
    load_test_data
    results = customer_repository.find_by_id("1")
    assert_equal "Joey", results.first_name
  end

  def test_find_all_by_id
    load_test_data
    results = customer_repository.find_all_by_id('2')
    assert_equal "Joey", results.last.first_name
  end

  def test_find_by_first_name
    load_test_data
    results = customer_repository.find_by_first_name("Joey")
    assert_equal "Ondricka", results.last_name
  end

  def test_find_all_by_first_name
    load_test_data
    results = customer_repository.find_all_by_first_name("Joey")
    assert_equal "Landers", results.last.last_name
  end

  def test_find_by_last_name
    load_test_data
    results = customer_repository.find_by_last_name("Ondricka")
    assert_equal "Joey", results.first_name
  end

  def test_find_all_by_last_name
    load_test_data
    results = customer_repository.find_all_by_last_name("Ondricka")
    assert_equal "Mary", results.last.first_name
  end

  def test_find_by_created_at
    load_test_data
    results = customer_repository.find_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal "Joey", results.first_name
  end

  def test_find_all_by_created_at
    load_test_data
    results = customer_repository.find_all_by_created_at("2012-03-27 14:54:09 UTC")
    assert_equal "Mary", results.last.first_name
  end

  def test_find_by_updated_at
    load_test_data
    results = customer_repository.find_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal "Ondricka", results.last_name
  end

  def test_find_all_by_updated_at
    load_test_data
    results = customer_repository.find_all_by_updated_at("2012-03-27 14:54:09 UTC")
    assert_equal "Mary", results.last.first_name
  end

end
