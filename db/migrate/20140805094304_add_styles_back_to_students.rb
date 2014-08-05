class AddStylesBackToStudents < ActiveRecord::Migration
  def change
  	add_column :students, :styles, :string, array:true, default:[]
  end
end
