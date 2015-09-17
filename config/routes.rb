Rails.application.routes.draw do
  resources :games do
    resources :players
    resource :player, only: [:show, :update]
  end

  get "/auth/google/callback" => "sessions#create"
  get "/logout" => "sessions#destroy", as: :logout
  get "/login" => "sessions#new", as: :login
  root to: "games#index"
end
