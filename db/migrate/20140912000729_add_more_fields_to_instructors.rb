class AddMoreFieldsToInstructors < ActiveRecord::Migration
  def change
    add_column :instructors, :email, :string
    add_column :instructors, :phone, :string
    add_column :instructors, :facebook, :string
  end
end
