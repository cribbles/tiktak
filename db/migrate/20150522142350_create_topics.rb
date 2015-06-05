class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.text :title
      t.timestamps null: false
      t.datetime :last_posted
    end
  end
end
