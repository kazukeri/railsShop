require 'test_helper'

class ProductsOrdersControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end
  
  def test_show
    get :show, :id => ProductsOrder.first
    assert_template 'show'
  end
  
  def test_new
    get :new
    assert_template 'new'
  end
  
  def test_create_invalid
    ProductsOrder.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    ProductsOrder.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to products_order_url(assigns(:products_order))
  end
  
  def test_edit
    get :edit, :id => ProductsOrder.first
    assert_template 'edit'
  end
  
  def test_update_invalid
    ProductsOrder.any_instance.stubs(:valid?).returns(false)
    put :update, :id => ProductsOrder.first
    assert_template 'edit'
  end

  def test_update_valid
    ProductsOrder.any_instance.stubs(:valid?).returns(true)
    put :update, :id => ProductsOrder.first
    assert_redirected_to products_order_url(assigns(:products_order))
  end
  
  def test_destroy
    products_order = ProductsOrder.first
    delete :destroy, :id => products_order
    assert_redirected_to products_orders_url
    assert !ProductsOrder.exists?(products_order.id)
  end
end
