class CreateInstructors < ActiveRecord::Migration
  def change
    create_table :instructors do |t|
      t.integer :user_id
      t.text :address
      t.integer :certificates, array: true, default: []
      t.date :teach_since
      t.string :styles, array: true, default: []

      t.timestamps
    end
  end
end
