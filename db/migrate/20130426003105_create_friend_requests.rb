class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
      t.integer     :user_id,         :null => false
      t.integer     :from_user_id,    :null => false
      t.string      :invite_token,    :null => true
      t.integer     :status,          :null => false
      t.timestamps
    end
    add_index :friend_requests, [:user_id, :from_user_id], :unique => true
    add_index :friend_requests, [:user_id]
    add_index :friend_requests, [:from_user_id]
    add_index :friend_requests, [:user_id, :status]
    add_index :friend_requests, [:invite_token]
  end
end
