class AddColumnToPostsFlagged < ActiveRecord::Migration
  def change
    add_column :posts, :flagged, :boolean, default: false
  end
end
