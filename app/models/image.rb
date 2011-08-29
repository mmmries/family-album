require 'mongoid_grid'

class Image
  include Mongoid::Document
  include Mongoid::Grid
  field :date, type: Date
  field :people, type: Array
  field :notes, type: String
  field :status, type: String # The statuses should follow the path of imported->tagged
  attachment :image
end