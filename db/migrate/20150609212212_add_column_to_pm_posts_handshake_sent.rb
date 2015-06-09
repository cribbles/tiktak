class AddColumnToPmPostsHandshakeSent < ActiveRecord::Migration
  def change
    add_column :pm_posts, :handshake_sent, :boolean, default: :false
  end
end
