class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable, :omniauthable, :registerable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable
  
  field :admin, type: Boolean
  
  has_and_belongs_to_many :albums
  
  def has_album?(a)
    !albums.index(a).nil?
  end
end
