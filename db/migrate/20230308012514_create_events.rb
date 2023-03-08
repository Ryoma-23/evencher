class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.integer :user_id, null: false
      t.integer :comment_id, null: false
      t.integer :bookmark_id, null: false
      t.integer :group_id, null: false
      t.string :name, null: false
      t.text :introduction, null: false
      t.integer :season_start, null: false
      t.integer :season_end
      t.integer :time_start, null: false
      t.integer :time_end
      t.string :place, null: false
      t.integer :price
      t.boolean :is_active, null: false

      t.timestamps
    end
  end
end
