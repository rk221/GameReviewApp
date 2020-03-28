Rails.application.routes.draw do
  get '/home', to: 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :reviews
  resources :games
  resources :genres 

  resources :users do
    post :confirm, action: :confirm_new, on: :new
    match :confirm, action: :confirm_edit, on: :member, via: [:patch, :put]
  end
  
  post '/like/:review_id' => 'likes_for_user_reviews#create', as: 'like'
  delete '/like/:review_id' => 'likes_for_user_reviews#destroy', as: 'unlike'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  

  root to: 'home#index'
end
