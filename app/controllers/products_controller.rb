class ProductsController < ApplicationController

  before_filter :require_user, 
    :except => [:public_show]
  before_filter :require_user_admin, 
    :except => [:public_show]  

  def public_show
   
    @categories = Category.all
    @product = Product.find(params[:id])

  end  
  
  def index
    @products = Product.all
  end
  
  def show
    @product = Product.find(params[:id])
  end
  
  def new
    @categories = Category.all
    @product = Product.new
  end
  
  def create
    
    
    
    @product = Product.new(params[:product])
    if @product.save
      flash[:notice] = "Zapisano produkt"
      redirect_to @product
    else
      render :action => 'new'
    end
  end
  
  def edit
    @categories = Category.all
    @product = Product.find(params[:id])
  end
  
  def update
    @product = Product.find(params[:id])
    if @product.update_attributes(params[:product])
      flash[:notice] = "Zapisano produkt"
      redirect_to @product
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    flash[:notice] = "Usunięto produkt"
    redirect_to products_url
  end
end
