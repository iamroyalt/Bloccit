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
  #creating posts/:post_id/comments routes
  resources :posts, only: [] do
  #only add create and destroy routes for comments
  resources :comments, only: [:create, :destroy]
     end
  resources :users, only: [:new, :create]
  resources :sessions, only: [:new, :create, :destroy]
  get 'about' => 'welcome#about'
  root 'welcome#index'
end
