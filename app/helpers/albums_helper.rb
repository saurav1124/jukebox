module AlbumsHelper

  def can_edit_album(album)
    user_signed_in? && album.user_id == current_user.id
  end

end
