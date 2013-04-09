module PlaylistsHelper

  def can_edit_playlist(pl)
    user_signed_in? && pl.user_id == current_user.id
  end

end
