namespace :media do
  desc "imports all images in a directory with blank meta data"
  task :import => :environment do
    puts "hello"
    i = Image.new
    i.status = "imported"
    i.image = File.open("/home/hqmq/walle.jpg")
    i.save
  end
end