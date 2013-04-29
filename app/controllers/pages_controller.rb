class PagesController < ApplicationController

  layout :resolve_layout
  
  before_filter :check_signed_in!, :except => [:index, :request_invite, :accept_invite]
  
  def index
    if user_signed_in?
      redirect_to home_path
    end
  end
  
  def home
    @tracks = Track.where("user_id = ?", current_user.id).limit(40)
    plLimit = @tracks.count > 0 ? @tracks.count/2 : 10
    plLimit = 10 if plLimit < 10
    @playlists = Playlist.where("user_id = ?", current_user.id).order("list_type, order_no").limit(plLimit)
    albLimit = @tracks.count > 0 ? (@tracks.count - plLimit) : 10
    albLimit = 10 if albLimit < 10
    @albums = Album.where("user_id = ?", current_user.id).limit(albLimit)
    @tmenu = "library"
    if request.headers["top-menu"]
      render "pages/home", :layout => "left_nav_partial"
    end
  end
  
  def search
    search = Sunspot.search(Track) do
      fulltext params[:q]
      # adjust_solr_params do |params|
        # params[:qf] = "title^1.5 category^1.0 keywords^1.0 description^1.0" unless noTermSearch
        # params[:bf] = "recip(ms(NOW,created_at),3.16e-11,1,1)" unless noTermSearch
        # params[:bf] = "recip(geodist(location_ll," + session[:search_loc][:lat].to_s + "," + session[:search_loc][:lng].to_s + "),2,200,20)" unless nonLocBased
        # params[:mm] = 0 unless noTermSearch
      # end
      # with(:location).in_radius(session[:search_loc][:lat].to_f, session[:search_loc][:lng].to_f, params[:distance].to_i) unless nonLocBased
      paginate :page => params[:page], :per_page => 15
      # order_by(:created_at, :desc) if noTermSearch
    end
    @tracks = search.results
    @albums = Album.all
  end
  
  def request_invite
    flash[:thanks] = t("txt.invite_req_thanks")
    redirect_to thanks_path
  end
  
  def accept_invite
    session[:fr_token] = params[:token]
    redirect_to new_registration_path(resource_name)
  end
  
private

  def resolve_layout
    case action_name
    when "home"
      return "left_nav"
    else
      return "page"
    end
  end

end
