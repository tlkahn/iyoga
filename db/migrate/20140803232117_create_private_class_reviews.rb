class CreatePrivateClassReviews < ActiveRecord::Migration
  def change
    create_table :private_class_reviews do |t|
      t.integer :private_class_id
      t.integer :user_id
      t.integer :score
      t.text :comments

      t.timestamps
    end
  end
end
