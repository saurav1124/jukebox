module UsersHelper

  def my_playlists
    Playlist.where("user_id = ? and list_type in (?)", current_user.id, Playlist::ADDABLE_LISTS).order("list_type, order_no").limit(10)
  end

  def my_albums
    Album.limit(10)
  end
  
  def my_tracks
    Track.limit(40)
  end

end
