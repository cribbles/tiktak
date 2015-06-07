class AddColumnToPmTopicsPostId < ActiveRecord::Migration
  def change
    add_column :pm_topics, :post_id, :integer, null: :false
  end
end
