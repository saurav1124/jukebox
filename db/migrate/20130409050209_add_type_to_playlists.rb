class AddTypeToPlaylists < ActiveRecord::Migration
  def change
    remove_column :playlists, :syslist
    add_column    :playlists, :list_type, :integer, :null => false, :default => 100
    add_index     :playlists, [:user_id, :list_type]
    add_index     :playlists, [:user_id, :list_type, :order_no], :unique => true
  end
end
