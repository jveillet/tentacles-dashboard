Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboard#index'
  get '/auth/user', to: 'sessions#new', as: :signin
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy', as: :signout
  get '/auth/failure', to: 'sessions#failure'
  get '/:username/settings', to: 'settings#index', as: :settings
end
