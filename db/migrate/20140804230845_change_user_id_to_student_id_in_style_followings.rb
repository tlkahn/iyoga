class ChangeUserIdToStudentIdInStyleFollowings < ActiveRecord::Migration
  def change
  	rename_column :style_followings, :user_id, :student_id
  end
end
