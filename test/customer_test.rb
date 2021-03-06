require_relative 'test_helper'
require_relative '../lib/customer'
require_relative '../lib/sales_engine'

class CustomerTest < Minitest::Test
  attr_reader :data

  def setup
    @data =   {
                id:         "1",
                first_name: "Joey",
                last_name:  "Ondricka",
                created_at: "2012-03-27 14:54:09 UTC",
                updated_at: "2012-03-27 14:54:09 UTC"
              }
  end

  def test_it_has_an_id
    customer = Customer.new(data, nil)
    assert_equal 1, customer.id
  end

  def test_it_has_a_first_name
    customer = Customer.new(data, nil)
    assert_equal "Joey", customer.first_name
  end

  def test_it_has_a_last_name
    customer = Customer.new(data, nil)
    assert_equal "Ondricka", customer.last_name
  end

  def test_it_has_a_created_at_date
    customer = Customer.new(data, nil)
    assert_equal "2012-03-27 14:54:09 UTC", customer.created_at
  end

  def test_it_has_an_updated_at_date
    customer = Customer.new(data, nil)
    assert_equal "2012-03-27 14:54:09 UTC", customer.updated_at
  end

  def test_invoices_calls_parent
    parent = Minitest::Mock.new
    customer = Customer.new(data, parent)
    parent.expect(:find_invoices, nil, [1])
    customer.invoices
    parent.verify
  end

  def test_transactions
    se = SalesEngine.new(nil)
    se.startup
    assert_equal 7, se.customer_repository.customers[0].transactions.size
    assert se.customer_repository.customers[0].transactions.is_a?(Array)
    assert se.customer_repository.customers[0].transactions[0].is_a?(Transaction)
    assert_equal "4580251236515201", se.customer_repository.customers[0].transactions[1].credit_card_number
  end

  def test_favorite_merchant
    se = SalesEngine.new(nil)
    se.startup
    assert_equal 7, se.customer_repository.customers[3].transactions.size
    assert_equal 'Rutherford, Bogan and Leannon', se.customer_repository.customers[50].favorite_merchant.name
  end
end
