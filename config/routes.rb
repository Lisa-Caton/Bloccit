Rails.application.routes.draw do
  # get 'posts/index'
  # get 'posts/show'
  # get 'posts/new'
  # get 'posts/edit'
  # can replace all of these generated routes with a more succinct syntax with
  # resources :posts
  # we call the resources method and pass it a Symbol
  resources :posts

  # get 'welcome/index'
  # get 'welcome/about'

  # get 'welcome/contact'
  # get 'welcome/faq'

  # more succinct syntax
  # we remove get "welcome/index" because we've declared the index view as the root view
  #We also modify the about route to allow users to visit /about, rather than /welcome/about
  get 'about' => 'welcome#about'

  root 'welcome#index'
end
