class PostsController < ApplicationController

  before_action :require_sign_in, except: :show
  before_action :authorize_user, except: [:show, :new, :create]

  def new
    @topic = Topic.find(params[:topic_id])
    @post = Post.new
  end

  def create
    @topic = Topic.find(params[:topic_id])
    @post = @topic.posts.build(post_params)
    @post.user = current_user
    #properly scope the new post

    if @post.save
      flash[:notice] = "Post was saved."
      redirect_to [@topic, @post]
      # we change the redirect to use the nested post path.

    else
      flash.now[:alert] = "There was an error saving the post. Please try again."
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Post was updated."
      redirect_to [@post.topic, @post]
      # we change the redirect to use the nested post path.

    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])

    if @post.destroy
      flash[:notice] = "\"#{@post.title}\" was deleted successfully."
      redirect_to @post.topic
      # when a post is deleted, we direct users to the topic show view.
    else
      flash.now[:alert] = "There was an error deleting the post."
      render :show
    end
  end

  # remember to add private methods to the bottom of the file. Any method defined below private, will be private.
   private
   def post_params
     params.require(:post).permit(:title, :body)
   end

   def authorize_user
     post = Post.find(params[:id])

     # we redirect the user unless they own the post they're attempting to modify, or they're an admin
     unless current_user == post.user || current_user.admin? || current_user.moderator?
       flash[:error] = "You must be an admin or moderator to do that."
       redirect_to [post.topic, post]
     end
   end
 end



