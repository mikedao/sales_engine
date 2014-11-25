require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative 'test_helper'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :data1, :data2, :data3
  def setup
    @data1 = { id: "1",
               name: "Schroeder-Jerde",
               created_at: "2012-03-27 14:53:59 UTC",
               updated_at: "2012-03-27 14:53:59 UTC"
             }

    @data2 = { id: "2",
               name: "Sear",
               created_at: "2013-03-27 14:53:59 UTC",
               updated_at: "2013-03-27 14:53:59 UTC"
             }

    @data3 = { id: "3",
               name: "McDonalds",
               created_at: "2012-03-27 14:53:59 UTC",
               updated_at: "2012-03-27 14:53:59 UTC"
             }
  end

  def test_it_starts_empty
    merchant_repository = MerchantRepository.new
    assert merchant_repository.data.empty?
  end

  def test_it_has_merchants
    merchant_repository = MerchantRepository.new
    merchant_repository << Merchant.new(data1)
    merchant_repository << Merchant.new(data2)
    merchant_repository << Merchant.new(data3)
    refute merchant_repository.data.empty?
  end

  def test_it_has_three_merchants
    merchant_repository = MerchantRepository.new
    merchant_repository << Merchant.new(data1)
    merchant_repository << Merchant.new(data2)
    merchant_repository << Merchant.new(data3)
    assert_equal 3, merchant_repository.data.size
  end

  def test_it_can_access_individual_merchants
    merchant_repository = MerchantRepository.new
    merchant_repository << Merchant.new(data1)
    merchant_repository << Merchant.new(data2)
    merchant_repository << Merchant.new(data3)
    assert_equal "McDonalds", merchant_repository.data[2].name
  end
end
