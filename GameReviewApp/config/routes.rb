Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :reviews
  resources :games
  post '/like/:review_id' => 'likes_for_user_reviews#create', as: 'like'
  delete '/like/:review_id' => 'likes_for_user_reviews#destroy', as: 'unlike'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  

  root to: 'sessions#new'
end
