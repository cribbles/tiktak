class AddIndexToPostsUser < ActiveRecord::Migration
  def change
    add_reference :posts, :user, null: true, index: true, foreign_key: true
  end
end
