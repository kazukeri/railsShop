class Order < ActiveRecord::Base
  attr_accessible :user_id
   has_many :products_orders, :dependent => :destroy
   has_many :products, :through => :products_orders  
   belongs_to :user
end
