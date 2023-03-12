class CreateEventTags < ActiveRecord::Migration[6.1]
  def change
    create_table :event_tags do |t|
      t.references :event, foreign_key: true
      t.references :tag, foreign_key: true

      t.timestamps
    end
    # 同じタグを２回保存するのは出来ないようになる
    add_index :event_tags, [:event_id, :tag_id], unique: true
  end
end
