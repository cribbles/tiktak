class CreatePmTopics < ActiveRecord::Migration
  def change
    create_table :pm_topics do |t|
      t.datetime :last_posted

      t.timestamps null: false
    end
  end
end
