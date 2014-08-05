class CreateStyleFollowings < ActiveRecord::Migration
  def change
    create_table :style_followings do |t|
      t.integer :user_id
      t.integer :style_id

      t.timestamps
    end
  end
end
