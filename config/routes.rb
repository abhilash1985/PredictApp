# Rails routes
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'users/sign_in', to: 'dashboard#welcome'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users do
  end
  get 'dashboard/welcome'
  root 'dashboard#index'
  resources :dashboard, only: :index
  resources :tournaments, only: [:index, :show] do
    member do
      get :leaderboard
      get :leader_board
    end
    collection do
      post :predict_match
      post :update_match
    end
  end

  resources :challenges do
    member do
      get :points_table
      get :predictions_table
      get :payment_details
      get :challenge_payments
      get :prize_list
      get :show_user_challenges
      post :update_user_challenges
    end
  end
end
