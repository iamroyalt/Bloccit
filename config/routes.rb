Rails.application.routes.draw do
  #get 'posts/index'

  #get 'posts/show'

  #get 'posts/new'

  #get 'posts/edit'

  #get 'welcome/index'

  #get 'welcome/about'
  #resources :posts
  #resources :topics
  resources :topics do
  resources :posts, except: [:index]
   end
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  get 'about' => 'welcome#about'
  root 'welcome#index'
end
