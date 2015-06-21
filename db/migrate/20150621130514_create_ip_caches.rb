class CreateIpCaches < ActiveRecord::Migration
  def change
    create_table :ip_caches do |t|
      t.integer :ip_addr, limit: 8, null: false
      t.string  :hostname, null: false
      t.boolean :blacklisted, default: false

      t.timestamps null: false
    end
    add_index :ip_caches, :ip_addr, unique: true
  end
end
