class Tweet < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  has_many :votes

  validates :user, :text, presence: true
  validates :text, length: { maximum: 140 }

  def self.in_period(range)
    range.is_a?(Range) ? where(created_at: range) : where(nil)
  end

  def with_count_by_user
    select('user_id, COUNT(*) as total_tweets')
      .group(:user_id)
  end

  def with_average_rating_by_user
    select('user_id, (SUM(votes_count) / COUNT(*)) as average_rating')
      .group(:user_id)
  end

  def rating
    votes.size
  end
end
