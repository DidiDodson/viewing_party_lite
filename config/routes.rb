Rails.application.routes.draw do
  root to: 'main#index'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/users/:user_id', to: 'users#show', as: "user_show"

  get '/users/:user_id/discover', to: 'discover#show', as: "discover_show"
  get '/users/:user_id/movies', to: 'movies#index', as: "movie_index"
  get '/users/:user_id/movies/:id', to: 'movies#show', as: "movie_show"

  get '/users/:user_id/movies/:id/viewing_party/new', to: 'viewing_party#new', as: "new_viewing_party"
  post '/users/:user_id/movies/:id/viewing_party/new', to: 'viewing_party#create'
end
