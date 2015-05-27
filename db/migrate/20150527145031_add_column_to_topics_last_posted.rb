class AddColumnToTopicsLastPosted < ActiveRecord::Migration
  def change
    add_column :topics, :last_posted, :datetime
  end
end
