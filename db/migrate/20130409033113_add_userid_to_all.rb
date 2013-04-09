class AddUseridToAll < ActiveRecord::Migration
  def change
    add_column :artists,          :user_id,           :integer, :null => false
    add_index  :artists,          [:user_id]
    add_column :track_artists,    :user_id,           :integer, :null => false
    add_index  :track_artists,    [:user_id]
  end
end
