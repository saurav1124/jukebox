# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'open-uri'
require 'csv'

if !Rails.env.production?
  # create dj user for dev
  user = User.create!(:name => "DJ", :email => "dj@miliea.com", :password => "jbjb2012")
  #user = User.find_by_email("dj@miliea.com")
  # load sample library
  library_path = ENV['JB_LIBRARY_PATH'] ||= "#{Rails.root}/db/sample/tracks"
  JB::MediaLoader.load(user.id, library_path)
end
