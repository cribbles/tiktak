class CreatePmRelationships < ActiveRecord::Migration
  def change
    create_table :pm_relationships do |t|
      t.integer :sender_id
      t.integer :recipient_id

      t.timestamps null: false
    end
    add_index :pm_relationships, :sender_id
    add_index :pm_relationships, :recipient_id
    add_index :pm_relationships, [:id, :sender_id, :recipient_id],
                                 unique: true
  end
end
