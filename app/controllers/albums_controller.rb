class AlbumsController < ApplicationController

  layout :resolve_layout
  
  before_filter :check_signed_in!
  
  def index
    @tmenu = "albums"
    @albums = Album.where("user_id = ?", current_user.id).order("name")
    if request.headers["top-menu"]
      render "albums/index", :layout => false
    else
      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @albums }
      end
    end
  end

  def show
    @tmenu = "albums"
    @albums = Album.where("user_id = ?", current_user.id).order("name")
    if params[:uqid].present?
      @album = Album.find_by_uqid(params[:uqid])
    else
      @album = Album.find_by_uqid(params[:id])
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @album }
    end
  end
  
  def tracks
    if params[:uqid].present?
      @album = Album.find_by_uqid(params[:uqid])
    else
      @album = Album.find_by_uqid(params[:id])
    end
    @tracks = Track.where("album_id = ?", params[:id])
    render "albums/tracks", :layout => false
  end

private

  def resolve_layout
    case action_name
    when "show"
      return "left_nav"
    else
      return "page"
    end
  end

end
