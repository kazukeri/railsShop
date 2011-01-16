class UsersController < ApplicationController

  before_filter :require_user, 
    :except => [:new,:create]
  before_filter :require_user_admin, 
    :except => [:edit,:update,:new,:create]  
  
  
  def new
    @user = User.new
  end
  
  def index
    @users = User.all
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Konto zostało założone"
      redirect_to root_url
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
    @orders = @user.orders
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = "Dane zostały zmienione"
      redirect_to root_url
    else
      render :action => 'edit'
    end
  end
end
