require 'digest/sha1'

class User
  include Mongoid::Document
  
  field :username
  field :password_hash
  has_and_belongs_to_many :roles
  
  # helper method for accepting passwords when a user is logging in or setting the password
  def password=(pass)
    password_hash = Digest::SHA1.hexdigest(pass)
  end
end
