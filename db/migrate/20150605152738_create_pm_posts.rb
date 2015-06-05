class CreatePmPosts < ActiveRecord::Migration
  def change
    create_table :pm_posts do |t|
      t.text :content
      t.references :pm_topic, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.string :ip_address

      t.timestamps null: false
    end
  end
end
