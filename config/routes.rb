Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/sessions/login' => 'sessions#login'
  post '/sessions/register' => 'sessions#register'

  namespace :api do
    namespace :v1 do
      # users
      get '/users' => 'users#index'
      get '/users/:id' => 'users#show'
      post '/users' => 'users#create'
      put '/users/:id' => 'users#update'
      delete '/users/:id' => 'users#destroy'

      # articles
      get '/articles' => "articles#index"
      get '/articles/:id' => 'articles#show'
      post '/articles' => 'articles#create'
      put '/articles/:id' => 'articles#update'
      delete '/articles/:id' => 'articles#destroy'
    end
  end

end
