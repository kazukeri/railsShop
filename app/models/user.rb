class User < ActiveRecord::Base
  attr_accessible :login, :email, :password, 
    :password_confirmation,:role_type  # new; WARNING: Can't mass-assign protected attributes

  acts_as_authentic do |c|
    c.validates_length_of_password_field_options= {:within => 2..14}
    c.validates_length_of_password_confirmation_field_options= {:within => 2..14}    
    c.validates_uniqueness_of_login_field_options= {:case_sensitive => true}
    c.validates_uniqueness_of_email_field_options= {:case_sensitive => true}
  end

  has_many :orders

end
