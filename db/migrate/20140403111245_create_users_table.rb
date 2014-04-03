class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |user|
      user.string :handle
      user.string :name
      user.string :password
      user.timestamps
    end
  end
end
