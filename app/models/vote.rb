class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :tweet, counter_cache: true

  validates :user, :tweet, presence: true
  validates :tweet, uniqueness: { scope: [:user] }
end
