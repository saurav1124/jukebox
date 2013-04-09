module UsersHelper

  def my_playlists
    Playlist.where("user_id = ?", current_user.id).order("syslist desc, order_no").limit(10)
  end

  def my_albums
    Album.limit(10)
  end
  
  def my_tracks
    Track.limit(40)
  end

end
