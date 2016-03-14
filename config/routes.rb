Rails.application.routes.draw do
  #get 'questions/index'

  #get 'questions/show'

  #get 'questions/new'

  #get 'questions/create'

  #get 'questions/update'

  #get 'questions/edit'

  #get 'questions/destroy'

  #get 'posts/index'

  #get 'posts/show'

  #get 'posts/new'

  #get 'posts/edit'

  #get 'welcome/index'

  #get 'welcome/about'
  resources :questions
  resources :posts
  get 'about' => 'welcome#about'
  root 'welcome#index'
end
