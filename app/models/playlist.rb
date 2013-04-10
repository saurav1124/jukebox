class Playlist < ActiveRecord::Base

  include ModelHelper
  
  attr_accessible :name, :user_id, :order_no, :personal, :list_type
  
  has_many :playlist_tracks, :dependent => :destroy
  has_many :tracks, :through => :playlist_tracks, :order => "order_no"

  before_create :set_uqid

  TYPE_FAVORITE         = 24
  TYPE_RECENT_PLAYED    = 32
  TYPE_MOST_PLAYED      = 36
  TYPE_FRIENDS_PLAYED   = 64
  TYPE_DEFAULT          = 100
  
  ADDABLE_LISTS = [TYPE_FAVORITE, TYPE_DEFAULT]
  
  def display_name
    list_type < 100 ? I18n.t(name) : name
  end
  
  def syslist?
    list_type < 100
  end
  
  def icon
    case list_type
    when TYPE_FAVORITE
      return "star"
    when TYPE_RECENT_PLAYED, TYPE_MOST_PLAYED
      return "fire"
    when TYPE_FRIENDS_PLAYED
      return "friends"
    else
      return "playlist"
    end
  end
  
private

  def set_uqid
    self.uqid = gen_unique_key_for_model(16)
    self.url = "/t/" + self.uqid
  end

end
