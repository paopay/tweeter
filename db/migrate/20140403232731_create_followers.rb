class CreateFollowers < ActiveRecord::Migration
  def change
    create_table :followers do |f|
      f.integer :user_id

  end
end
