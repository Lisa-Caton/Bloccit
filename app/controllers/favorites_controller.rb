class FavoritesController < ApplicationController

   before_action :require_sign_in
   # we redirect guest users to sign in before allowing them to favorite a post.


  def create
    # we find the post we want to favorite using the post_id in params.
    # We then create a favorite for the current_user, passing in the post to establish associations for the 
    # user, post, and favorite.
     post = Post.find(params[:post_id])
     favorite = current_user.favorites.build(post: post)
 
     if favorite.save
       flash[:notice] = "Post favorited."
     else
       flash[:alert] = "Favoriting failed."
     end

     redirect_to [post.topic, post]
     # we redirect the user to the post's show view
  end

  def destroy
     post = Post.find(params[:post_id])
     favorite = current_user.favorites.find(params[:id])
 
     if favorite.destroy
       flash[:notice] = "Post unfavorited."
     else
       flash[:alert] = "Unfavoriting failed."
     end
       redirect_to [post.topic, post]
   end
end
