class User < ActiveRecord::Base
  # attr_accessor :email, :first_name, :last_name, :password_confirmation  

  has_secure_password  
  
  validates_presence_of :first_name, :last_name, :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  before_create { generate_token(:auth_token) }  
    
  def generate_token(column)  
    begin  
      self[column] = SecureRandom.urlsafe_base64  
    end while User.exists?(column => self[column])  
  end  

  def full_name
    "#{first_name} #{last_name}"
  end
end
