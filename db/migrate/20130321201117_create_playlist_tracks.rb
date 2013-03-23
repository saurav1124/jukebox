class CreatePlaylistTracks < ActiveRecord::Migration
  def change
    create_table :playlist_tracks do |t|
      t.column        :playlist_id,     :integer,   :null => false
      t.column        :track_id,        :integer,   :null => false
      t.column        :order_no,        :integer,   :null => false
      t.timestamps
    end
    add_index :playlist_tracks, [:playlist_id]
    add_index :playlist_tracks, [:playlist_id, :track_id], :unique => true
    add_index :playlist_tracks, [:playlist_id, :order_no], :unique => true
  end
end
