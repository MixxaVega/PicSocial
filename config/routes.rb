Rails.application.routes.draw do
  get 'relationships/follow_user'

  get 'relationships/unfollow_user'

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
  post ":username/follow_user", to: "relationships#follow_user", as: :follow_user
  post ":username/unfollow_user", to: "relationships#unfollow_user", as: :unfollow_user
  
  root "pics#index"

  #resources :users
  #user_profile "users#index"
  get "users/index"
  get "users/follows"

end
