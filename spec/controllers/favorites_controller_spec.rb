require 'rails_helper'
include SessionsHelper

RSpec.describe FavoritesController, type: :controller do 

  let(:my_topic) { create(:topic) }
  let(:my_user) { create(:user) }
  let(:my_post) { create(:post, topic: my_topic, user: my_user) }

   context 'guest user' do
     describe 'POST create' do
       it 'redirects the user to the sign in view' do

         post :create, params: { post_id: my_post.id }

         # we test that we're redirecting guests if they attempt to favorite a post.
         expect(response).to redirect_to(new_session_path)
       end
     end

     describe 'DELETE destroy' do
       it 'redirects the user to the sign in view' do
        # we test that we redirect guest users to sign in before allowing them to unfavorite a post.
         favorite = my_user.favorites.where(post: my_post).create
         delete :destroy, params: { post_id: my_post.id, id: favorite.id }
         expect(response).to redirect_to(new_session_path)
       end
     end
   end

   context 'signed in user' do
     before do
       create_session(my_user)
     end

     describe 'POST create' do

       it 'redirects to the posts show view' do

         post :create, params: { post_id: my_post.id }
         expect(response).to redirect_to([my_topic, my_post])
         # we expect that after a user favorites a post, we redirect them back to the post's show view.
       end
 
       it 'creates a favorite for the current user and specified post' do


         expect(my_user.favorites.find_by_post_id(my_post.id)).to be_nil
         # we expect that no favorites exist for the user and post.

         post :create, params: { post_id: my_post.id }

         expect(my_user.favorites.find_by_post_id(my_post.id)).not_to be_nil
        # we expect that after a user has favorited a post, they will have a favorite associated with that post.
       end
     end

     describe 'DELETE destroy' do
       it 'redirects to the posts show view' do
        # we test that when a user unfavorites a post, we redirect them to the post's show view.
         favorite = my_user.favorites.where(post: my_post).create
         delete :destroy, params: { post_id: my_post.id, id: favorite.id }
         expect(response).to redirect_to([my_topic, my_post])
       end

       it 'destroys the favorite for the current user and post' do
         favorite = my_user.favorites.where(post: my_post).create

         expect( my_user.favorites.find_by_post_id(my_post.id) ).not_to be_nil
         #  we expect that the user and post has an associated favorite that we can delete.

         delete :destroy, params: { post_id: my_post.id, id: favorite.id }

         expect( my_user.favorites.find_by_post_id(my_post.id) ).to be_nil
         # we expect that the associated favorite is nil
       end
     end
   end
 end
