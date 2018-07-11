Rails.application.routes.draw do

  # we call the resources method and pass it a Symbol
  resources :posts
  resources :advertisements

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
