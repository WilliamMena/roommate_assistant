class CreateListViewers < ActiveRecord::Migration
  def change
    create_table :list_viewers do |t|
      t.integer :list_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
