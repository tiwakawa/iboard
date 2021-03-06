Iboard::Application.routes.draw do
  root to: 'tops#index'

  resources :tops, only: :index
  resources :topics, only: [:show, :new, :create, :destroy] do
    resources :comments, only: [:new, :create, :destroy]
  end

  match "/auth/:provider/callback" => "sessions#callback"
  match "/auth/failure" => "sessions#failure"
  match "/logout" => "sessions#destroy", as: :logout
end
