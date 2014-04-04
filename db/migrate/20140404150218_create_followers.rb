class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |f|
      f.integer :user_id
      f.integer :follower_id
      f.timestamps
    end
  end
end
