desc "import an entire directroy of image files into a given album"
task :import_dir, [:dir, :album] => [:environment] do |t, args|
  album = Album.where(:name => args.album).first
  if album.nil? then
    puts "Failed to find album #{args.album}"
    return false
  end
  
  Dir.glob(File.join([args.dir, "*.jpg"])).each do |img_file|
    puts "importing #{img_file}"
    Picture.import_image_file(img_file, album)
  end
end
