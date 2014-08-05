class RemoveStyleColumnInStudents < ActiveRecord::Migration
  def change
    remove_column :students, :style
  end
end
