class Project
  include Mongoid::Document
  
  field :name, type: String
  field :date, type: Date
  
  has_many :images
end