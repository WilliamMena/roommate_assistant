class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.integer :user_id
      t.integer :list_type

      t.timestamps null: false
    end
  end
end
