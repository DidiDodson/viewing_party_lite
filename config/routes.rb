Rails.application.routes.draw do
  root to: 'main#index'

  get '/login',           to: 'sessions#new', as: "user_login"
  post '/login',          to: 'sessions#create', as: "login_user"
  delete '/logout',       to: 'sessions#destroy', as: 'user_logout'
  get '/logout',          to: 'sessions#destroy', as: 'logout_user'
  get '/register',        to: 'users#new'
  post '/register',       to: 'users#create'
  get '/dashboard',       to: 'users#show', as: "user_dashboard"

  get '/discover',        to: 'discover#show', as: "discover_show"
  get '/movies',          to: 'movies#index', as: "movie_index"
  get '/movies/:id',      to: 'movies#show', as: "movie_show"

  get '/movies/:id/viewing_party/new',  to: 'party#new', as: "new_viewing_party"
  post '/movies/:id/viewing_party/new', to: 'party#create'

  namespace :admin do
    get '/dashboard',             to: 'users#index'
    get '/users/:user_id',        to: 'users#show'  
    get '/login',                 to: 'sessions#new', as: "user_login"
    post '/login',                to: 'sessions#create', as: "login_user"
  end
end
