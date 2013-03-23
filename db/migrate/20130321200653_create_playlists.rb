class CreatePlaylists < ActiveRecord::Migration
  def change
    create_table :playlists do |t|
      t.column        :name,        :string,    :null => false, :limit => 32
      t.column        :user_id,     :integer,   :null => false
      t.column        :order_no,    :integer,   :null => false
      t.column        :personal,    :boolean,   :null => false, :default => 1
      t.column        :syslist,     :boolean,   :null => false, :default => 0
      t.column        :uqid,        :string,    :null => false, :limit => 128
      t.column        :url,         :string,    :null => false, :limit => 256
      t.timestamps
    end
    add_index :playlists, [:name]
    add_index :playlists, [:user_id]
    add_index :playlists, [:user_id, :name], :unique => true
    add_index :playlists, [:user_id, :personal]
    add_index :playlists, [:user_id, :syslist]
    add_index :playlists, [:user_id, :syslist, :order_no], :unique => true
  end
end
