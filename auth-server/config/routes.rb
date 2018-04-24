Rails.application.routes.draw do
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:create]

  get '/iapi/sessions', to: 'sessions#verify'

  get '/login', to: 'sessions#new'
  delete '/sessions', to: 'sessions#destroy'
end
