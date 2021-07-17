Rails.application.routes.draw do
  namespace :v1, formats: { default: :json } do
    resources :users, only: %i[create show]
    resources :sessions, only: %i[create]
    resources :accounts, only: %i[create show]
  end
end
