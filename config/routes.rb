Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :pics do
  	member do
  		put "like", to: "pics#upvote"
  		put "dislike", to: "pics#downvote"
  	end
    resources :comments
  end

  post "search", to: "users#search"
  
  root "pics#index"

  #resources :users
  #user_profile "users#index"
  get "users/index"

end
