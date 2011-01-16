class CategoriesController < ApplicationController
  before_filter :require_user, 
    :except => [:main, :public_show,:public_about,:public_contact]
  before_filter :require_user_admin, 
    :except => [:main, :public_show,:public_about,:public_contact]
    
  def main
    @products = Product.paginate :page => params[:page] || 1, :limit =>5, :per_page => 5, :order => 'created_at DESC'
    @categories = Category.all
  end

  def public_about
    
  end
  def public_contact
    
  end  
  def public_show
   
    @categories = Category.all
    @category = Category.find(params[:id])
    @products = @category.products.paginate :page => params[:page] || 1, :per_page => 5, :order => 'created_at DESC'
  end

  def index
    @categories = Category.all
  end
  
  def show
    @category = Category.find(params[:id])
  end
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(params[:category])
    if @category.save
      flash[:notice] = "Zapisano kategorię"
      redirect_to @category
    else
      render :action => 'new'
    end
  end
  
  def edit
    @category = Category.find(params[:id])
  end
  
  def update
    @category = Category.find(params[:id])
    if @category.update_attributes(params[:category])
      flash[:notice] = "Zapisano kategorię"
      redirect_to @category
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:notice] = "Usunięto kategorię"
    redirect_to categories_url
  end
end
