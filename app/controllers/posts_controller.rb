class PostsController < ApplicationController
  def index
    @posts = Post.all
     # we declare an instance variable @posts and assign it a collection of Post objects using the all method provided by ActiveRecord.
     # all returns a collection of Post objects.
     @posts.each_with_index do |post, id|
       if id % 5 == 0
         post.title = "SPAM"
       end
     end
  end

  def show
  end

  def new
  end

  def edit
  end
end
