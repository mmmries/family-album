class Album
  include Mongoid::Document
  
  field :name, type: String
  
  has_many :pictures
  has_and_belongs_to_many :users
end
