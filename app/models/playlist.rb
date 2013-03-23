class Playlist < ActiveRecord::Base

  include ModelHelper
  
  attr_accessible :name, :user_id, :order_no, :personal, :syslist

  before_create :set_uqid
  
  def display_name
    syslist ? I18n.t(name) : name
  end

private

  def set_uqid
    self.uqid = gen_unique_key_for_model(16)
    self.url = "/t/" + self.uqid
  end

end
