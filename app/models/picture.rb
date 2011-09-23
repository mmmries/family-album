require 'mongoid_grid'
require 'RMagick'
require 'digest'

class Picture
  include Mongoid::Document
  include Mongoid::Grid
  
  identity type: String #an md5 of the fullsize picture to avoid duplicates
  field :date, type: Date
  field :people, type: Array
  field :notes, type: String
  field :tags, type: Array
  field :status, type: String # The statuses should follow the path of imported->tagged
  attachment :fullsize
  attachment :medium
  attachment :thumbnail
  
  belongs_to :album
  
  def self.import_image_file(filename, album)
    pic = Picture.new
    pic.album = album
    pic.id = Digest::MD5.file(filename).to_s
    pic.fullsize = File.open(filename)
    fullsize = Magick::Image.read(filename).first
    fullsize.thumbnail!(400,400)
    med_path = File.join(["/tmp", "thumb-#{File.basename(filename)}"])
    fullsize.write(med_path)
    pic.medium = File.open(med_path)
    fullsize.thumbnail!(100,100)
    thumb_path = File.join(["/tmp", "med-#{File.basename(filename)}"])
    fullsize.write(thumb_path)
    pic.thumbnail = File.open(thumb_path)
    
    pic.status = "imported"
    pic.save
    
    File.delete(med_path) if File.exists?(med_path)
    File.delete(thumb_path) if File.exists?(thumb_path)
  end
end
