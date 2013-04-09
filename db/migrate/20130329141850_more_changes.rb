class MoreChanges < ActiveRecord::Migration
  def change
    # add user_id to albums and tracks
    add_column :albums,     :user_id,           :integer, :null => false
    add_index  :albums,     [:user_id]
    add_column :tracks,     :user_id,           :integer, :null => false
    add_index  :tracks,     [:user_id]
    # add last_played
    add_column :albums,     :last_played_at,    :datetime, :null => true
    add_index  :albums,     [:last_played_at]
    add_column :tracks,     :last_played_at,    :datetime, :null => true
    add_index  :tracks,     [:last_played_at]
    # add play_count
    add_column :tracks,     :play_count,        :integer, :null => false, :default => 0
    add_index  :tracks,     [:play_count]
  end
end
