class AddColumnToPostsContact < ActiveRecord::Migration
  def change
    add_column :posts, :contact, :boolean, { default: false }    
  end
end
