class CreateFollowings < ActiveRecord::Migration
  def change
    create_table :followings do |f|
      f.integer :user_id
      f.integer :following_id
      f.timestamps
    end
  end
end
