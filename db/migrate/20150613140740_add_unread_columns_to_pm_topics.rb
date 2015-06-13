class AddUnreadColumnsToPmTopics < ActiveRecord::Migration
  def change
    add_column :pm_topics, :sender_unread, :boolean, default: true
    add_column :pm_topics, :recipient_unread, :boolean, default: true
  end
end
