class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.integer     :me_id,       :null => false
      t.integer     :user_id,     :null => false
      t.integer     :status,      :null => false, :default => 0
      t.timestamps
    end
    add_index :friends, :me_id
    add_index :friends, [:me_id, :user_id], :unique => true
    add_index :friends, [:user_id]
    add_index :friends, [:me_id, :status]
  end
end
