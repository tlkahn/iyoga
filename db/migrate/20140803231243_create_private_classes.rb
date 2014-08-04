class CreatePrivateClasses < ActiveRecord::Migration
  def change
    create_table :private_classes do |t|
      t.integer :teacher_id
      t.integer :students, array: true, default: []
      t.datetime :start_time
      t.string :style, array: true, default: []

      t.timestamps
    end
  end
end
