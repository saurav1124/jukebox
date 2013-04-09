class CreateUserTracks < ActiveRecord::Migration
  def change
    create_table :user_tracks do |t|
      t.column      :user_id,         :integer, :null => false
      t.column      :track_id,        :integer, :null => false
      t.column      :play_count,      :integer, :null => false, :default => 0
      t.column      :last_played_at,  :integer, :null => false, :default => 0
      t.timestamps
    end
    add_index :user_tracks, [:user_id]
    add_index :user_tracks, [:user_id, :track_id], :unique => true
    add_index :user_tracks, [:user_id, :play_count]
  end
end
