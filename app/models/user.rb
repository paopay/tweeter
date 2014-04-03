class User < ActiveRecord::Base
  has_many :tweets
  validates_uniqueness_of :handle
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
end
