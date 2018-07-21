Rails.application.routes.draw do

  # we call the resources method and pass it a Symbol
  resources :topics do 
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
   end

  resources :users, only: [:new, :create]
  resources :advertisements
  resources :questions

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
