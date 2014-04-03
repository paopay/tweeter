class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |tweet|
      tweet.belongs_to  :user
      tweet.string      :content
      tweet.string      :location
      tweet.timestamps

    end
  end
end
