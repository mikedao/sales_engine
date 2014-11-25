require_relative 'test_helper'
require_relative '../lib/customer'

class CustomerTest < Minitest::Test
  attr_reader :data

  def setup
    @data = { id:         1,
              first_name: "Joey",
              last_name:  "Ondricka",
              created_at: "2012-03-27 14:54:09 UTC",
              updated_at: "2012-03-27 14:54:09 UTC"
           }
  end

  def test_it_has_an_id
    customer = Customer.new(data)

    assert_equal 1, customer.id
  end

  def test_it_has_a_first_name
    customer = Customer.new(data)

    assert_equal "Joey", customer.first_name
  end

  def test_it_has_a_last_name
    customer = Customer.new(data)

    assert_equal "Ondricka", customer.last_name
  end

  def test_it_has_a_created_at_date
    customer = Customer.new(data)

    assert_equal "2012-03-27 14:54:09 UTC", customer.created_at
  end

  def test_it_has_an_updated_at_date
    customer = Customer.new(data)

    assert_equal "2012-03-27 14:54:09 UTC", customer.updated_at
  end
end
