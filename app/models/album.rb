class Album < ActiveRecord::Base

  attr_accessible :name

  include ModelHelper

  has_one       :artwork

  before_create :set_uqid

private

  def set_uqid
    self.uqid = gen_unique_key_for_model(16)
    self.url = "/a/" + self.uqid
  end

end
