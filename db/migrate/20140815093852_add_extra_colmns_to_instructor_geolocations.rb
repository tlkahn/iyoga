class AddExtraColmnsToInstructorGeolocations < ActiveRecord::Migration
  def change
  	add_column :instructor_geolocations, :street, :string
		add_column :instructor_geolocations, :street_number, :string
		add_column :instructor_geolocations, :zip, :string
		add_column :instructor_geolocations, :city, :string
		add_column :instructor_geolocations, :country, :string
		add_column :instructor_geolocations, :state, :string

		remove_column :instructors, :street1
		remove_column :instructors, :street2
		remove_column :instructors, :city
		remove_column :instructors, :state
		remove_column :instructors, :country
		remove_column :instructors, :zip
		remove_column :instructors, :latitude
		remove_column :instructors, :longitude

  end
end
