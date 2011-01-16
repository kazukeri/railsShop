class Product < ActiveRecord::Base
  attr_accessible :title, :shortdescription, :description, :price, :category_id,:photo,:photo_file_name,:photo_content_type,:photo_file_size, :amount
  belongs_to :category
  has_attached_file :photo,
     :styles => {
       :thumb=> "100x100#",
       :small  => "400x400>" }
 
end
