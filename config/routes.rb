Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      # auth
      get     '/auth/token',            to: 'auth#token'

      # users
      get     '/users',                 to: 'users#index'
      get     '/users/:id',             to: 'users#show'
      post    '/users',                 to: 'users#create'
      post    '/users/:id',             to: 'users#update'
      delete  '/users/:id',             to: 'users#destroy'

      # articles
      get     '/articles',              to: 'articles#index'
      get     '/articles/:id',          to: 'articles#show'
      post    '/articles',              to: 'articles#create'
      put     '/articles/:id',          to: 'articles#update'
      delete  '/articles/:id',          to: 'articles#destroy'
      put     '/articles/:id/like',     to: 'articles#like'

      # resources
      get     '/resources',             to: 'resources#index'
      get     '/resources/:id',         to: 'resources#show'
      post    '/resources',             to: 'resources#create'
      delete  '/resources/:id',         to: 'resources#destroy'

      # spiders
      get     '/spiders/accounts',      to: 'spiders#accounts'
      post    '/spiders/accounts',      to: 'spiders#create_account'
      put     '/spiders/accounts/:id',  to: 'spiders#update_account'
      delete  '/spiders/accounts/:id',  to: 'spiders#delete_account'
      get     '/spiders/submits',       to: 'spiders#submits'
      get     '/spiders/workers',       to: 'spiders#workers'

      # achievements
      get     '/achievements',          to: 'achievements#index'

      # misc
      get     '/misc/dashboard',        to: 'misc#dashboard'
    end
  end

end
