class AddDetailsToAddressInInstructors < ActiveRecord::Migration
  def change
  	remove_column :instructors, :address
  	add_column :instructors, :street1, :string
  	add_column :instructors, :street2, :string
  	add_column :instructors, :city, :string
  	add_column :instructors, :state, :string
  	add_column :instructors, :country, :string
  	add_column :instructors, :zip, :string
  	add_column :instructors, :latitude, :float
  	add_column :instructors, :longitude, :float
  end
end
