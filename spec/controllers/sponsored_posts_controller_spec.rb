require 'rails_helper'
require 'random_data'

RSpec.describe SponsoredPostsController, type: :controller do

   let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
   let(:my_sponsored_post) { my_topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 100) }


  describe "GET #show" do
    it "returns http success" do
      get :show, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      get :show, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
      expect(response).to render_template :show
    end

    it "assigns my_sponsored_post to @post" do
      get :show, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
      expect(assigns(:sponsored_posts)).to eq(my_sponsored_post)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      get :new, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
      expect(response).to render_template :new
    end

    it "instantiates @sponsored_posts" do
      get :new, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
      expect(assigns(:sponsored_posts)).not_to be_nil
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      get :edit, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
      expect(response).to render_template :edit
    end

    it "assigns sponsored_posts to be updated to @sponsored_posts" do
      get :edit, params: { topic_id: my_topic.id, id: my_sponsored_post.id }

      post_instance = assigns(:sponsored_posts)

      expect(post_instance.id).to eq my_sponsored_post.id
      expect(post_instance.title).to eq my_sponsored_post.title
      expect(post_instance.body).to eq my_sponsored_post.body
    end
  end

   describe "POST create" do
    it "increases the number of Sponsored Post by 1" do
      expect{post :create, params: { topic_id: my_topic.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } } }.to change(SponsoredPost, :count).by(1)
    end

    it "assigns the new sponsored_post to @sponsored_post" do
      post :create, params: { topic_id: my_topic.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
      expect(assigns(:sponsored_posts)).to eq SponsoredPost.last
    end

    it "redirects to the new sponsored post" do
      post :create, params: { topic_id: my_topic.id, sponsored_post: { title: RandomData.random_sentence, body: RandomData.random_paragraph } }
      expect(response).to redirect_to [my_topic, SponsoredPost.last]
    end
  end

  describe "PUT update" do
    it "updates post with expected attributes" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, 
        params: { 
          topic_id: my_topic.id, 
          id: my_sponsored_post.id, 
          sponsored_posts: {title: new_title, body: new_body } 
      }

      updated_post = assigns(:sponsored_posts)
      expect(updated_post.id).to eq my_sponsored_post.id
      expect(updated_post.title).to eq new_title
      expect(updated_post.body).to eq new_body
    end

    it "redirects to the updated post" do
      new_title = RandomData.random_sentence
      new_body = RandomData.random_paragraph

      put :update, params: { topic_id: my_topic.id, id: my_sponsored_post.id, sponsored_posts: {title: new_title, body: new_body } }
      expect(response).to redirect_to [my_topic, my_sponsored_post]
    end
  end

  describe "DELETE destroy" do
    it "deletes the post" do
      delete :destroy, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
      count = SponsoredPost.where({id: my_sponsored_post.id}).size
      expect(count).to eq 0
    end

    it "redirects to topic show" do
       delete :destroy, params: { topic_id: my_topic.id, id: my_sponsored_post.id }
       expect(response).to redirect_to my_topic
    end
  end

end
