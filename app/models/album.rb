class Album
  include Mongoid::Document
  
  field :name, type: String
  
  has_many :pictures
end
