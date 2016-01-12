class User < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true

  has_many :tweets
  has_many :votes
end
