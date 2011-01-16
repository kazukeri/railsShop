require 'test_helper'

class ProductsOrderTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert ProductsOrder.new.valid?
  end
end
