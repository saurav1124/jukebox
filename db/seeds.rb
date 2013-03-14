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
  thefile = "#{Rails.root}/db/sample/tracks.txt"
  puts "Loading sample tracks ..."
  CSV.foreach(thefile) do |row|
    album = Album.where("name = ?", row[1].strip).first
    if album == nil
      album = Album.new(:name => row[1].strip)
      album.save!
    end
    artist = Artist.where("name = ?", row[2].strip).first
    if artist == nil
      artist = Artist.new(:name => row[2].strip)
      artist.save!
    end
    Track.create(:title => row[0].strip, :artist_id => artist.id, :album_id => album.id, :year => row[3].to_i, :track_length => 300, :rating => 0)
  end
  puts "Finished Loading Sample Tracks"
end
