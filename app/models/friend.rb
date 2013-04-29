class Friend < ActiveRecord::Base

  attr_accessible :me_id, :user_id, :status

  belongs_to :me, :class_name => "User", :foreign_key => "me_id"
  belongs_to :user

end
