class AddSecureFieldToUser < ActiveRecord::Migration
  def change
  	add_column :messages, :left_shows, :integer, default: -1, null: false
  	add_column :messages, :deadline, :integer, default: -1, null: false
  end
end
