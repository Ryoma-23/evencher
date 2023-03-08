class CreateEvents < ActiveRecord::Migration[6.1]
  def change
    create_table :events do |t|
      t.string :name, null: false
      t.text :introduction, null: false
      t.date :season_start, null: false
      t.date :season_end
      t.time :time_start, null: false
      t.time :time_end
      t.string :place, null: false
      t.integer :price
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
