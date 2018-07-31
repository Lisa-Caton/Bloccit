Rails.application.routes.draw do

  # we call the resources method and pass it a Symbol
  resources :topics do 
    resources :posts, except: [:index]
    resources :sponsored_posts, except: [:index]
   end

  resources :posts, only: [] do
  # we use only: [] because we don't want to create any /posts/:id routes, just posts/:post_id/comments routes

    resources :comments, only: [:create, :destroy]
    # we only add create and destroy routes for comments.
    # we'll display comments on the posts show view, so we won't need index or new routes.
    # We also won't give users the ability to view individual comments or edit comments, removing the need for show, update, and edit routes.
  
  post '/up-vote' => 'votes#up_vote', as: :up_vote
  post '/down-vote' => 'votes#down_vote', as: :down_vote
  end

  resources :users, only: [:new, :create]
  post 'users/confirm' => 'users#confirm'

  resources :sessions, only: [:new, :create, :destroy]

  resources :advertisements
  resources :questions

  get 'about' => 'welcome#about'
  get 'faq' => 'welcome#faq'

  root 'welcome#index'
end
