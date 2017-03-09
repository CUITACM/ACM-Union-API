Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      # auth
      get     '/auth/token',                  to: 'auth#token'

      # users
      get     '/users',                       to: 'users#index'
      get     '/users/:id',                   to: 'users#show'
      post    '/users',                       to: 'users#create'
      post    '/users/:id',                   to: 'users#update'
      delete  '/users/:id',                   to: 'users#destroy'

      # articles
      get     '/articles',                    to: 'articles#index'
      get     '/solutions',                   to: 'articles#solutions'
      get     '/articles/:id',                to: 'articles#show'
      post    '/articles',                    to: 'articles#create'
      put     '/articles/:id',                to: 'articles#update'
      delete  '/articles/:id',                to: 'articles#destroy'
      put     '/articles/:id/like',           to: 'articles#like'
      get     '/articles/:id/comments',       to: 'articles#comments'
      post    '/articles/:id/comments',       to: 'articles#create_comment'

      # resources
      get     '/resources',                   to: 'resources#index'
      get     '/resources/:id',               to: 'resources#show'
      post    '/resources',                   to: 'resources#create'
      delete  '/resources/:id',               to: 'resources#destroy'

      # spiders
      get     '/spiders/accounts',            to: 'spiders#accounts'
      post    '/spiders/accounts',            to: 'spiders#create_account'
      put     '/spiders/accounts/:id',        to: 'spiders#update_account'
      delete  '/spiders/accounts/:id',        to: 'spiders#delete_account'
      get     '/spiders/submits',             to: 'spiders#submits'
      get     '/spiders/workers',             to: 'spiders#workers'
      put     '/spiders/workers/:oj',         to: 'spiders#open_worker'
      delete  '/spiders/workers/:oj',         to: 'spiders#stop_worker'

      # achievements
      get     '/achievements',                to: 'achievements#index'
      get     '/achievements/:id',            to: 'achievements#show'
      post    '/achievements',                to: 'achievements#create'
      put     '/achievements/:id',            to: 'achievements#update'
      delete  '/achievements/:id',            to: 'achievements#destroy'

      # honors
      get     '/honors',                      to: 'honors#index'
      get     '/honors/:id',                  to: 'honors#show'
      post    '/honors',                      to: 'honors#create'
      post    '/honors/:id',                  to: 'honors#update'
      delete  '/honors/:id',                  to: 'honors#destroy'

      # misc
      get     '/misc/dashboard',              to: 'misc#dashboard'

      # achievements
      get     '/comments',                    to: 'comments#index'
      get     '/comments/:id',                to: 'comments#show'
      post    '/comments',                    to: 'comments#create'
      put     '/comments/:id',                to: 'comments#update'
      delete  '/comments/:id',                to: 'comments#destroy'
    end
  end

end
