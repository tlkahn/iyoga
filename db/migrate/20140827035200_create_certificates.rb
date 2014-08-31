class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.string :title
      t.integer :institute_id

      t.timestamps
    end
  end
end
