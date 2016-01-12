class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet

  validates :user, :tweet, presence: true
end