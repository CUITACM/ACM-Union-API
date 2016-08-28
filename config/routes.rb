Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/sessions/login' => 'sessions#login'
  post '/sessions/register' => 'sessions#register'

  namespace :api do
    namespace :v1 do
      # users
      get     '/users',         to: 'users#index'
      get     '/users/:id',     to: 'users#show'
      post    '/users',         to: 'users#create'
      put     '/users/:id',     to: 'users#update'
      delete  '/users/:id',     to: 'users#destroy'

      # articles
      get     '/articles',      to: "articles#index"
      get     '/articles/:id',  to: 'articles#show'
      post    '/articles',      to: 'articles#create'
      put     '/articles/:id',  to: 'articles#update'
      delete  '/articles/:id',  to: 'articles#destroy'
    end
  end

end
