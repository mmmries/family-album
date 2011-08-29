class Image
  include Mongoid::Document
  field :date, Date
  field :people, Array
  field :notes, String
end