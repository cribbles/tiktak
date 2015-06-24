class AddColumnToIpCachesHellbanned < ActiveRecord::Migration
  def change
    add_column :ip_caches, :hellbanned, :boolean, default: false
  end
end
