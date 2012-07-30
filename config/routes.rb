Iboard::Application.routes.draw do
  root to: 'tops#index'

  resources :tops, only: :index

  match "/auth/:provider/callback" => "sessions#callback"
  match "/auth/failure" => "sessions#failure"
  match "/logout" => "sessions#destroy", as: :logout
end
