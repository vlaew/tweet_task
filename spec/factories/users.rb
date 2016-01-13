FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "user_#{n}" }
  end

  factory :user_with_tweets, parent: :user, class: User do
    transient do
      tweets_count 10
      date_range { Time.zone.today..Time.zone.today }
    end

    after(:create) do |user, evaluator|
      evaluator.tweets_count.times do
        create(:tweet, user: user, created_at: evaluator.date_range.to_a.sample)
      end
    end
  end
end
