class AddArtworkToAlbums < ActiveRecord::Migration
  def change
    add_column :albums, :artwork_id, :integer, :null => true
  end
end
