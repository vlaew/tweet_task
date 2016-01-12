class Tweet < ActiveRecord::Base
  belongs_to :user
  has_many :votes

  validates :user, :text, presence: true
  validates :text, length: { maximum: 140 }

  def rating
    votes.count
  end
end
