class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string        :name,      :null => false, :limit => 255
      t.string        :nickname,  :null => true, :limit => 32
      t.date          :dob,       :null => true
      t.timestamps
    end
  end
end
