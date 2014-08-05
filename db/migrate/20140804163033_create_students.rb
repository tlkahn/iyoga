class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :style, array: true, default: []
      t.datetime :practice_since
      t.string :phone
      t.text :introduction

      t.timestamps
    end
  end
end
