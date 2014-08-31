class CreatePractices < ActiveRecord::Migration
  def change
    create_table :practices do |t|
      t.integer :instructor_id
      t.integer :style_id

      t.timestamps
    end
  end
end
