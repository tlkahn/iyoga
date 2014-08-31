class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.integer :instructor_id
      t.integer :certificate_id

      t.timestamps
    end
  end
end
