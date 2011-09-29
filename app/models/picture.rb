require 'mongoid_grid'
require 'RMagick'
require 'digest'

class Picture
  include Mongoid::Document
  include Mongoid::Grid
  include Mongoid::Timestamps
  
  identity type: String #an md5 of the fullsize picture to avoid duplicates
  field :date, type: Date
  field :people, type: Array, :index => true
  field :notes, type: String
  field :tags, type: Array, :index => true
  field :views, type: Integer
  attachment :fullsize
  attachment :medium
  attachment :thumbnail
  
  index :needs_tagging, :sparse => true
  
  belongs_to :album
  
  def self.import_image_file(filename, album)
    pic = Picture.new
    pic.album = album
    pic.id = Digest::MD5.file(filename).to_s
    pic.fullsize = File.open(filename)
    fullsize = Magick::Image.read(filename).first
    medium = fullsize.change_geometry('400x400') { |cols,rows, img| img.resize(cols,rows) }
    med_path = File.join(["/tmp", "thumb-#{File.basename(filename)}"])
    medium.write(med_path)
    pic.medium = File.open(med_path)
    thumbnail = fullsize.change_geometry('100x100') { |cols, rows, img| img.resize(cols,rows) }
    thumb_path = File.join(["/tmp", "med-#{File.basename(filename)}"])
    thumbnail.write(thumb_path)
    pic.thumbnail = File.open(thumb_path)
    
    pic[:needs_tagging] = true
    pic.save
    
    File.delete(med_path) if File.exists?(med_path)
    File.delete(thumb_path) if File.exists?(thumb_path)
  end
  
  def people_string
    if people.nil? then
      ""
    else
      people.join(", ")
    end
  end
  
  def tags_string
    if tags.nil? then
      ""
    else
      tags.join(", ")
    end
  end
end
