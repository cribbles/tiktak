class AddIndexToTopicsUser < ActiveRecord::Migration
  def change
    add_reference :topics, :user, null: true, index: true, foreign_key: true
  end
end
