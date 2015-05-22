class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :content
      t.references :topic, index: true, foreign_key: true

      t.timestamps null: false
    end
    add_index :posts, [:topic_id, :created_at]
  end
end
