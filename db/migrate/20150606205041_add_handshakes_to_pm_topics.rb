class AddHandshakesToPmTopics < ActiveRecord::Migration
  def change
    add_column :pm_topics, :sender_handshake,    :boolean, default: false
    add_column :pm_topics, :recipient_handshake, :boolean, default: false
    add_column :pm_topics, :handshake_declined,  :boolean, default: false
  end
end
