class AddColumnsToTopicsHellbannedLastPostedHb < ActiveRecord::Migration
  def change
    add_column :topics, :hellbanned, :boolean, default: false
    add_column :topics, :last_posted_hb, :datetime
  end
end
