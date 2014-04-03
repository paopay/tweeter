class ChangeTweets < ActiveRecord::Migration
  def change
    change_column :tweets, :content, :string, :limit => 140
  end
end
