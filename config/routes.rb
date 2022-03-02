Rails.application.routes.draw do
  resources :reminders
  root to: 'reminders#index'

  get 'users/new' => 'users#new', as: :new_user
  post 'users' => 'users#create'

  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'
end
