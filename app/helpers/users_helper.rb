module UsersHelper
  def not_submitted_posts
    if @user.has_posts?
      render @user.posts
    else
      link_to {@user.name} + " has not submitted any posts yet."
    end
  end



  def not_submitted_comments
    if @user.has_comments?
      render @user.comments
    else
      link_to {@user.name} + " has not submitted any comments yet."
    end
  end


  def not_submitted_favorites
    if @user.has_favorites?

      @user.favorites.each do |favorite|
        render partial: 'users/favorite', locals: { post: favorite.post }
      end

    else
      link_to {@user.name} + " has not favorited any posts yet."
    end
  end




end
