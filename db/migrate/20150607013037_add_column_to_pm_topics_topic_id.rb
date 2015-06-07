class AddColumnToPmTopicsTopicId < ActiveRecord::Migration
  def change
    add_column :pm_topics, :topic_id, :integer, null: :false
  end
end
