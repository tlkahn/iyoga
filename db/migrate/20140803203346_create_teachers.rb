class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.integer :user_id
      t.text :address
      t.integer :certificate_id
      t.date :teaching_since
      t.string :style, array: true, default: []

      t.timestamps
    end
  end
end
