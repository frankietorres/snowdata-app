Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'home#index'
  # Defines the root path route ("/")
  # root "articles#index"

  get '/resorts', to: 'resorts#index'

  get 'snotel', to: 'snotel#index', as: :snotel_index
  get 'snotel/:station_name', to: 'snotel#show', as: :snotel_station

end
