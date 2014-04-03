class Tweet < ActiveRecord::Base
  belongs_to :user
  validates_length_of :content, minimum: 1, maximum: 140
end
