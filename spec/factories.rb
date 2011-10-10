require 'factory_girl'

Factory.define :album1, :class => :album do |a|
 a.name "album1" 
end

Factory.define :album2, :class => :album do |a|
  a.name "album2"
end

Factory.define :guest, :class => :user do |u|
end

Factory.define :user1, :class => :user do |u|
  u.email "user1@album.com"
  u.password "user1111"
end

Factory.define :user2, :class => :user do |u|
  u.email "user2@album.com"
  u.password "user2222"
end

Factory.define :admin, :class => :user do |u|
  u.email "admin@album.com"
  u.password "adminaaaa"
  u.admin true
end
