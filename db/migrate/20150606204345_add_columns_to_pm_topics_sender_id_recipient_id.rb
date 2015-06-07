class AddColumnsToPmTopicsSenderIdRecipientId < ActiveRecord::Migration
  def change
    add_column :pm_topics, :sender_id,    :integer, null: :false
    add_column :pm_topics, :recipient_id, :integer, null: :false
  end
end
