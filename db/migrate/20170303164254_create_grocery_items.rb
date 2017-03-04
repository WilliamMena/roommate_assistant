class CreateGroceryItems < ActiveRecord::Migration
  def change
    create_table :grocery_items do |t|
      t.integer :list_id
      t.integer :grocery_id
      t.boolean :bought, default: false

      t.timestamps null: false
    end
  end
end
