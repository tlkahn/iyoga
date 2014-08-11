class AddMoreDetailsToStudents < ActiveRecord::Migration
  def change
  	add_column :students, :college, :string
  	add_column :students, :language, :string, array: true, default: []
  	add_column :students, :interest, :string, array: true, default: []
  end
end
