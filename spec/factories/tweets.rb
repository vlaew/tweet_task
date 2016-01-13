FactoryGirl.define do
  factory :tweet do
    user nil
    text 'some text'
    created_at { Time.zone.now }

    factory :tweet_with_votes, parent: :tweet, class: Tweet do
      transient do
        rating 0
      end

      after(:create) do |tweet, evaluator|
        evaluator.rating.times do
          create(:vote, user: create(:user), tweet: tweet)
        end
      end
    end
  end
end
