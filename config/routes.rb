Rails.application.routes.draw do

  # we call the resources method and pass it a Symbol
  resources :topics do 
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
   end


  resources :users, only: [:new, :create]
  post 'users/confirm' => 'users#confirm'

  resources :sessions, only: [:new, :create, :destroy]

  resources :advertisements
  resources :questions

  get 'about' => 'welcome#about'

  root 'welcome#index'
end
