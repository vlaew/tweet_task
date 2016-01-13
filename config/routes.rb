Rails.application.routes.draw do
  root 'tweets#index'

  resources :tweets, only: [:index, :new, :create] do
    post 'vote', on: :member
  end
end
