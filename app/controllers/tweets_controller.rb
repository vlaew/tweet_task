class TweetsController < ApplicationController
  def index
    @tweets = Tweet.includes(:user)
                .order(created_at: :desc)
                .order(id: :desc)
                .page(params.fetch(:page, 1)).per(10)
  end

  def new
    @tweet = Tweet.new
  end

  def create
    result = Tweets::Creator.create(user: User.find_by(id: tweet_params[:user_id]), text: tweet_params[:text])
    if result.success
      redirect_to tweets_path
    else
      @tweet = result.tweet
      render 'new'
    end
  end

  def vote
    tweet = Tweet.find(params[:id])
    Tweets::Voter.vote(user: User.all.to_a.sample, tweet: tweet)
    redirect_to tweets_path
  end

  def statistic
    period = params[:period]
    @top_users = Tweets::Statistic.top_users(period: period)
    @top_tweets = Tweets::Statistic.top_tweets(period: period)
    @top_rating_users = Tweets::Statistic.top_rating_users(period: period)
  end

  private

  def tweet_params
    params.require(:tweet).permit(:user_id, :text)
  end
end
