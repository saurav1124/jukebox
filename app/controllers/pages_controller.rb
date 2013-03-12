class PagesController < ApplicationController

  layout :resolve_layout

  def index
  end
  
  def search
    
  end
  
private

  def resolve_layout
    return "home"
  end

end
