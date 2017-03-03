class CreateShoppingLists < ActiveRecord::Migration
  def change
    create_table :shopping_lists do |t|
      t.integer :grocery_id
      t.integer :user_id
      t.boolean :bought, default: false

      t.timestamps null: false
    end
  end
end
