require_relative 'test_helper'
require_relative '../lib/customer_repository'
require_relative '../lib/customer'

class CustomerRepositoryTest < Minitest::Test
  attr_reader :data1, :data2, :data3

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
               created_at: "2012-05-27 14:54:09 UTC",
               updated_at: "2012-05-27 14:54:09 UTC"
             }
  end

  def test_it_starts_empty
    customer_repository = CustomerRepository.new
    assert customer_repository.data.empty?
  end

  def test_it_has_customers
    customer_repository = CustomerRepository.new
    customer_repository << Customer.new(data1)
    customer_repository << Customer.new(data2)
    customer_repository << Customer.new(data3)
    assert_equal 3, customer_repository.data.size
  end

  def test_it_can_access_individual_customers
    customer_repository = CustomerRepository.new
    customer_repository << Customer.new(data1)
    customer_repository << Customer.new(data2)
    customer_repository << Customer.new(data3)
    assert_equal "Landers", customer_repository.data[1].last_name
  end
end
