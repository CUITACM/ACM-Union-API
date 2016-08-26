Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  post '/login' => 'sessions#login'
  post '/register' => 'sessions#register'

  namespace :api do
    namespace :v1 do
      get '/users' => 'users#index'
      post '/users/:id' => 'users#update'
    end
  end

end
