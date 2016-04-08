Rails.application.routes.draw do
 resources :labels, only: [:show]

#resource instructs Rails to create routes for creating, updating, viewing, and deleting instances
  resources :topics do
  resources :posts, except: [:index]
  end
  #creating posts/:post_id/comments routes
  resources :posts, only: [] do
  #only add create and destroy routes for comments
  resources :comments, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  #These new lines create POST routes at the URL posts/:id/up-vote and posts/:id/down-vote.
  #The as key-value pairs at the end stipulate the method names which will be associated with these routes: up_vote_path and down_vote_path.
  post '/up-vote' => 'votes#up_vote', as: :up_vote
  post '/down-vote' => 'votes#down_vote', as: :down_vote
  end
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:new, :create, :destroy]

  get 'about' => 'welcome#about'
  root 'welcome#index'

  namespace :api do
     namespace :v1 do
       resources :users, only: [:index, :show]
       resources :topics, only: [:index, :show]
       resources :posts, only: [:index, :show]
       resources :comments, only: [:index, :show]

     end
   end
end
