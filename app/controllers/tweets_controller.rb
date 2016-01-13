class TweetsController < ApplicationController
  def index
    @tweets = Tweet.order(created_at: :desc).per(10).page(params.fetch(:page, 1))
  end

  def new

  end

  def create

  end

  def vote

  end
end
