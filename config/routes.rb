Rails.application.routes.draw do

  # we call the resources method and pass it a Symbol
  resources :topics do 
    resources :posts, except: [:index]
    resources :sponsored_posts
   end

  resources :advertisements
  resources :questions

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
