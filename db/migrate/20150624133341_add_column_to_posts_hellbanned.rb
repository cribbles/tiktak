class AddColumnToPostsHellbanned < ActiveRecord::Migration
  def change
    add_column :posts, :hellbanned, :boolean, default: false
  end
end
