module PlaylistsHelper

  def can_edit_playlist(pl)
    user_signed_in? && pl.user_id == current_user.id
  end
  
  def playlist_tracks(playlist)
    if playlist.list_type == Playlist::TYPE_RECENT_PLAYED
      user_tracks = UserTrack.all(:include => :track,
                                  :conditions => ["user_id = ? and last_played_at is not null", current_user.id],
                                  :order => "last_played_at desc")
      user_tracks.map(&:track)
    elsif playlist.list_type == Playlist::TYPE_MOST_PLAYED
      Track.where("user_id = ? and play_count > 0", current_user.id).order("play_count desc")
    else
      playlist.tracks
    end
  end

end
