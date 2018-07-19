class SponsoredPostsController < ApplicationController
  def show
     @sponsored_posts = SponsoredPost.find(params[:id])
  end

  def new
  end

  def edit
  end
end
