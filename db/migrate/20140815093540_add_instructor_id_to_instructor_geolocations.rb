class AddInstructorIdToInstructorGeolocations < ActiveRecord::Migration
  def change
  	add_column :instructor_geolocations, :instructor_id, :integer
  end
end
