class PlaylistTrack < ActiveRecord::Base

  # attr_accessible :title, :body

  belongs_to :playlist
  belongs_to :track

end
