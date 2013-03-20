class AlbumArtist < ActiveRecord::Base
  
  attr_accessible :album_id, :artist_id
  
  belongs_to :album
  belongs_to :artist

  def name
    artist.name
  end

end
