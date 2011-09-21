require 'mongoid_grid'
require 'RMagick'

class Picture
  include Mongoid::Document
  include Mongoid::Grid
  
  field :date, type: Date
  field :people, type: Array
  field :notes, type: String
  field :tags, type: Array
  field :status, type: String # The statuses should follow the path of imported->tagged
  attachment :fullsize
  attachment :medium
  attachment :thumbnail
  
  belongs_to :album
  
  def attach_image_file!(filename)
    self.fullsize = File.open(filename)
    fullsize = Magick::Image.read(filename).first
    fullsize.thumbnail!(100,100)
    thumb_path = File.join(["/tmp", File.basename(filename)])
    fullsize.write(thumb_path)
    self.thumbnail = File.open(thumb_path)
    save
  end
end
