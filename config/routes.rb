Rails.application.routes.draw do
  #get 'posts/index'

  #get 'posts/show'

  #get 'posts/new'

  #get 'posts/edit'

  #get 'welcome/index'

  #get 'welcome/about'
  resources :posts
  get 'about' => 'welcome#about'
  root 'welcome#index'
end
