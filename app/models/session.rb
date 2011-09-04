require 'digest/sha1'

class Session
  include Mongoid::Document
  attr_accessor :username
  attr_accessor :password
  attr_accessor :password_hash
  
  def password=(pass)
    @password_hash = Digest::SHA1.hexdigest(pass)
  end
end
