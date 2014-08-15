class CreateInstructorGeolocations < ActiveRecord::Migration
  def change
    create_table :instructor_geolocations do |t|
      t.string :address
      t.float :longitude
      t.float :latitude

      t.timestamps
    end
  end
end
