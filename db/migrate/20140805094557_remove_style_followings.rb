class RemoveStyleFollowings < ActiveRecord::Migration
  def change
  	drop_table :style_followings
  end
end
