Rails.application.routes.draw do
#resource instructs Rails to create routes for creating, updating, viewing, and deleting instances
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
