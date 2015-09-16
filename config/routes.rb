Rails.application.routes.draw do
  get "/auth/google/callback" => "sessions#create"
  get "/logout" => "sessions#destroy", as: :logout
  get "/login" => "sessions#new", as: :login
  root to: "games#index"
end
