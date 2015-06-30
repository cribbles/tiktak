class CreateIpCaches < ActiveRecord::Migration
  def change
    create_table :ip_caches do |t|
      t.string  :ip_address,  null: false
      t.string  :hostname,    null: false
      t.boolean :blacklisted, default: false

      t.timestamps null: false
    end
    add_index :ip_caches, :ip_address, unique: true
  end
end
