class Tweet < ActiveRecord::Base
  belongs_to :user

  validates :user, :text, presence: true
  validates :text, length: { maximum: 140 }
end
