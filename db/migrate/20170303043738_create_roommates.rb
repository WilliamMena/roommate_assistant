class CreateRoommates < ActiveRecord::Migration
  def change
    create_table :roommates do |t|
      t.integer :user_id
      t.integer :roommate_id

      t.timestamps null: false
    end
  end
end
