class SponsoredPostsController < ApplicationController

  def show
    @sponsored_posts = SponsoredPost.find(params[:id])
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @sponsored_posts = SponsoredPost.new
  end

  def edit
    @topic = Topic.find(params[:topic_id])
    @sponsored_posts = SponsoredPost.find(params[:id])
  end

  def create
    @sponsored_posts = SponsoredPost.new
    @sponsored_posts.title = params[:sponsored_post][:title]
    @sponsored_posts.body = params[:sponsored_post][:body]
    @sponsored_posts.price = params[:sponsored_post][:price]
    @topic = Topic.find(params[:topic_id])
    @sponsored_posts.topic = @topic
    # we assign a topic to a sponsored_posts

    if @sponsored_posts.save
      flash[:notice] = "Sponsored post was saved."
      redirect_to [@topic, @sponsored_posts]
      # we change the redirect to use the nested sponsored_posts path.

    else
      flash.now[:alert] = "There was an error saving the sponsored post. Please try again."
      render :new
    end
    puts params
  end

  def update
    @sponsored_posts = SponsoredPost.find(params[:id])
    @sponsored_posts.title = params[:sponsored_posts][:title]
    @sponsored_posts.body = params[:sponsored_posts][:body]
    @sponsored_posts.price = params[:sponsored_posts][:price]

    if @sponsored_posts.save
      flash[:notice] = "Sponsored post was updated."
      redirect_to [@sponsored_posts.topic, @sponsored_posts]
      # we change the redirect to use the nested sponsored_posts path.

    else
      flash[:error] = "There was an error saving the sponsored post. Please try again."
      render :edit
    end
  end

  def destroy
    @topic = Topic.find(params[:topic_id])
    @sponsored_posts = SponsoredPost.find(params[:id])

    if @sponsored_posts.destroy
      flash[:notice] = "\"#{@sponsored_posts.title}\" was deleted successfully."
      redirect_to @topic
      # when a sponsored_posts is deleted, we direct users to the topic show view.
    else
      flash.now[:alert] = "There was an error deleting the sponsored post."
      render :show
    end
  end
end
