class AddSecureFieldToUser < ActiveRecord::Migration
  def change
  	add_column :messages, :left_shows, :integer, default: -1
  	add_column :messages, :deadline, :integer, default: -1
  	add_column :messages, :choice, :boolean, default: 0 # 0 - deadline; 1 - left_shows 
  end
end
