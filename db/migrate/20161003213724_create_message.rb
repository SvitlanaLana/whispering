class CreateMessage < ActiveRecord::Migration
  def change
    create_table :messages, id: false, force: true do |t|
      t.string :key, null: false
      t.string :text
      t.datetime :created_at
      t.datetime :updated_at
    end
    add_index :messages, [:key], name: "index_messages_on_key" , unique: true
  end
end
