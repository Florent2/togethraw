Rails.application.routes.draw do
  root "games#new"

  resources :games do
    put :start, on: :member
    put :toggle_cell, on: :member
    put :update_player_color, on: :member
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
