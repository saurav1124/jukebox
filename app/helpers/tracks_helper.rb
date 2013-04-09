module TracksHelper

  def top3_tracks_by_artist(artist_id)
    Track.joins(:artists).where("tracks.user_id = ? and track_artists.artist_id = ?", current_user.id, artist_id).order("play_count desc").limit(3)
  end

end
