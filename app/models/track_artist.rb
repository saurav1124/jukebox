class TrackArtist < ActiveRecord::Base

  attr_accessible :track_id, :artist_id
  
  belongs_to :track
  belongs_to :artist
  
  after_save :reindex_track

  def name
    artist.name
  end

private

  def reindex_track
    self.track.index
  end

end
