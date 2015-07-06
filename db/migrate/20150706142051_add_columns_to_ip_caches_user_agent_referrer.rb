class AddColumnsToIpCachesUserAgentReferrer < ActiveRecord::Migration
  def change
    add_column :ip_caches, :user_agent, :string
    add_column :ip_caches, :referrer, :string
  end
end
