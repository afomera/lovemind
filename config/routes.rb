Rails.application.routes.draw do


  devise_for :users
  match "search" => "resources#index", as: :search, via: [:get]
  resources :resources do
    resources :comments
    member do
    put "like", to: "resources#upvote"
    put "dislike", to: "resources#downvote"
    end
  end
  root 'resources#index'
end
