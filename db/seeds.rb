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
  # thefile = "#{Rails.root}/db/sample/tracks.txt"
  # puts "Loading sample tracks ..."
  # CSV.foreach(thefile, :col_sep => ",") do |row|
    # artist_ids = []
    # row[2].split(",").each do |name|
      # artist = Artist.where("name = ?", name.strip).first
      # if artist == nil
        # artist = Artist.new(:name => name.strip)
        # artist.save!
      # end
      # artist_ids << artist.id
    # end
    # album = Album.where("name = ?", row[1].strip).first
    # if album == nil
      # album = Album.new(:name => row[1].strip)
      # album.save!
    # end
    # artist_ids.each do |artist_id|
      # aa = AlbumArtist.where("album_id = ? and artist_id = ?", album.id, artist_id).first
      # if aa == nil
        # aa = AlbumArtist.new(:album_id => album.id, :artist_id => artist_id)
        # aa.save!
      # end
    # end
    # track = Track.create(:title => row[0].strip, :album_id => album.id, :year => row[3].to_i, :track_length => 313, :rating => 0)
    # artist_ids.each do |artist_id|
      # aa = TrackArtist.new(:track_id => track.id, :artist_id => artist_id)
      # aa.save!
    # end
  # end

  # filepath = "#{Rails.root}/db/sample/tracks/06 06. Phiriye Dewar Gaan.mp3"
  # track = Track.new
  # track.media = File.new(filepath)
  # track.save!
  
  Dir.foreach("#{Rails.root}/db/sample/tracks") do |item|
    next if item == '.' or item == '..'
    # do work on real items
    puts "adding #{Rails.root}/db/sample/tracks/" + item
    track = Track.new
    track.media = File.new("#{Rails.root}/db/sample/tracks/" + item)
    track.save!
  end
end
