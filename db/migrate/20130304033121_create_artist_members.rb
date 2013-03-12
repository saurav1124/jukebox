class CreateArtistMembers < ActiveRecord::Migration
  def change
    create_table :artist_members do |t|
      t.integer       :group_id,              :null => false
      t.integer       :artist_id,             :null => false
      t.timestamps
    end
  end
end
