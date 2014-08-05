class AddVisibleToUsersColumnToMessages < ActiveRecord::Migration
  def change
  	add_column :messages, :visible_to_receipient, :boolean
  end
end
