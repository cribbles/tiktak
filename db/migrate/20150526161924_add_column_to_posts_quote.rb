class AddColumnToPostsQuote < ActiveRecord::Migration
  def change
    add_column :posts, :quote, :integer, { default: nil }
  end
end
