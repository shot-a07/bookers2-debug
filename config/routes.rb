Rails.application.routes.draw do
  devise_for :users

  root 'homes#top'
  resources :users,only: [:show,:index,:edit,:update] do

  resource :relationships, only: [:create, :destroy]
  get 'followings' => 'relationships#followings', as: 'followings'
  get 'followers' => 'relationships#followers', as: 'followers'
  end

  resources :books do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end




  get 'home/about' => 'homes#about'
  get 'search' => 'searches#search'
  
end
