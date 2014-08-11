class RemoveTeachersTableForNextScaffolding < ActiveRecord::Migration
  def change
  	drop_table :teachers
  end
end
