Rails.application.routes.draw do
  namespace :v1, formats: { default: :json } do
    resources :users, only: %i[create]
    resources :sessions, only: %i[create]
    resources :accounts, only: %i[create]
  end
end
