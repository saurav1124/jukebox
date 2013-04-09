class ArtistMembersController < ApplicationController

  layout :resolve_layout
  
  before_filter :check_signed_in!
  
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
