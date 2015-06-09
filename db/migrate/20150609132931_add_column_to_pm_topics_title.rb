class AddColumnToPmTopicsTitle < ActiveRecord::Migration
  def change
    add_column :pm_topics, :title, :string, null: :false
  end
end
