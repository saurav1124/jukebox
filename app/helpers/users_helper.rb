module UsersHelper

  def my_playlists
    Playlist.where("user_id = ?", current_user.id).order("syslist desc, order_no")
  end

end
