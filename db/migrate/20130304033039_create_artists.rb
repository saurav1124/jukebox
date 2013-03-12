class CreateArtists < ActiveRecord::Migration
  def change
    create_table :artists do |t|
      t.string        :name,                  :null => false, :limit => 512
      t.string        :uqid,                  :null => false, :limit => 128
      t.string        :url,                   :null => false, :limit => 256
      t.integer       :artwork_id,            :null => true
      t.timestamps
    end
    add_index   :artists, [:name]
    add_index   :artists, [:uqid]
    add_index   :artists, [:url]
  end
end
