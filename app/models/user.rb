require 'digest/sha1'

class User
  include Mongoid::Document
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable, :recoverable, :registerable 
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  
  field :email, type: String
  field :password_hash, type: String
  field :admin, type: Boolean
  
  attr_accessor :password
  
  # helper method for accepting passwords when a user is logging in or setting the password
  def password=(pass)
    self.password_hash = Digest::SHA1.hexdigest(pass)
  end
end
