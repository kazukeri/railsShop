class ProductsOrdersController < ApplicationController
  def index
    @products_orders = ProductsOrder.all
  end
  
  def show
    @products_order = ProductsOrder.find(params[:id])
  end
  
  def new
    @products_order = ProductsOrder.new
  end
  
  def create
    @products_order = ProductsOrder.new(params[:products_order])
    if @products_order.save
      flash[:notice] = "Successfully created products order."
      redirect_to @products_order
    else
      render :action => 'new'
    end
  end
  
  def edit
    @products_order = ProductsOrder.find(params[:id])
  end
  
  def update
    @products_order = ProductsOrder.find(params[:id])
    if @products_order.update_attributes(params[:products_order])
      flash[:notice] = "Successfully updated products order."
      redirect_to @products_order
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @products_order = ProductsOrder.find(params[:id])
    @products_order.destroy
    flash[:notice] = "Successfully destroyed products order."
    redirect_to products_orders_url
  end
end
