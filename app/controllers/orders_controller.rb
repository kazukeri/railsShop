class OrdersController < ApplicationController

  before_filter :require_user, 
    :except => []
  before_filter :require_user_admin, 
    :except => [:user_to_basket,:user_basket,:user_clear_basket,:user_finalize_order,:user_order]  
  
  
  def user_order
    @order = Order.find(params[:id])
  end
  def user_finalize_order
    counter = 0
    
    inbasketarray = cookies.signed[:user_basket_products]
    
    if inbasketarray == nil

    else
      @in_basket = []
  


      order_data ={'user_id' => current_user.id}
      @order = Order.new(order_data)
      
      if @order.save

        for productid in inbasketarray 
         
          products_order_data = {'product_id' => productid,'order_id' => @order.id}
     
          @products_order = ProductsOrder.new(products_order_data)
          @products_order.save
        end 
        
        cookies.permanent.signed[:user_basket_products] = nil
        
        flash[:notice] = "Zamówienie zostało złożone."
        redirect_to :controller =>'orders', :action =>'user_basket'
      else
        flash[:notice] = "Zamówienie nie zostało złożone, prosimy spróbować ponownie."
        redirect_to :controller =>'orders', :action =>'user_basket'
      end      
        
    end  
  end
  
  def user_to_basket
    @in_basket = cookies.signed[:user_basket_products];
    if @in_basket == nil
      tobasketarray = [params[:tobasket]['id']]
      cookies.permanent.signed[:user_basket_products] = tobasketarray
    else
      tobasketarray = cookies.signed[:user_basket_products]
      tobasketarray.push(params[:tobasket]['id'])
      cookies.permanent.signed[:user_basket_products] = tobasketarray
    end
    redirect_to :controller =>'orders', :action =>'user_basket'
  end
   def user_clear_basket

     cookies.permanent.signed[:user_basket_products] = nil
   
    redirect_to :controller =>'orders', :action =>'user_basket'
  end 
   def user_basket 
     
    counter = 0
    
    inbasketarray = cookies.signed[:user_basket_products]
    
    if inbasketarray == nil

    else
      @in_basket = []
  
      for productid in inbasketarray 
        
        @in_basket[counter] = Product.find(productid)
        
        counter = counter+1
      end 
    end   


  #  @in_basket = cookies.signed[:user_basket_products];
    
    
    #cookies.permanent.signed[:user_basket_products] = cookies.signed[:user_basket_products] + 1;
    
  end 
  def index
    @orders = Order.all
  end
  
  def show
    @order = Order.find(params[:id])
  end
  
  def new
    @order = Order.new
  end
  
  def create
    @order = Order.new(params[:order])
    if @order.save
      flash[:notice] = "Successfully created order."
      redirect_to @order
    else
      render :action => 'new'
    end
  end
  
  def edit
    @order = Order.find(params[:id])
  end
  
  def update
    @order = Order.find(params[:id])
    if @order.update_attributes(params[:order])
      flash[:notice] = "Successfully updated order."
      redirect_to @order
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @order = Order.find(params[:id])
    @order.destroy
    flash[:notice] = "Successfully destroyed order."
    redirect_to orders_url
  end
end
