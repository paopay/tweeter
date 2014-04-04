class User < ActiveRecord::Base
  has_many :tweets
  has_many :followers
  has_many :followings

  validates_uniqueness_of :handle
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates_uniqueness_of :email
  validates_length_of :password, minimum: 1
end
