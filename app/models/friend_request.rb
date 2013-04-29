class FriendRequest < ActiveRecord::Base

  STATUS_PENDING = 0
  STATUS_ACCEPTED = 1
  STATUS_DECLINED = -1

  attr_accessible :user_id, :from_user_id, :status, :invite_token
  
  belongs_to :user
  belongs_to :from_user, :class_name => "User", :foreign_key => "from_user_id"

end
