class CreateStudentGeolocations < ActiveRecord::Migration
  def change
    create_table :student_geolocations do |t|
      t.string :address
      t.float :longitude
      t.float :latitude
      t.integer :student_id
      t.string :street
      t.string :street_number
      t.string :zip
      t.string :city
      t.string :country
      t.string :state

      t.timestamps
    end
  end
end
