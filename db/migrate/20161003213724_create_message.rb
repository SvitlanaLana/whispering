class CreateMessage < ActiveRecord::Migration
  def change
    create_table :messages, id: false, force: true do |t|
      t.string :key, null: false
      t.string :text, null: false
      t.datetime :created_at, null: false
      t.datetime :updated_at, null: false
    end
    add_index :messages, [:key], name: "index_messages_on_key" , unique: true
  end
end
