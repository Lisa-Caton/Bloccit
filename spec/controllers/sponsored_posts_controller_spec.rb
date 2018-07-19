require 'rails_helper'

RSpec.describe SponsoredPostsController, type: :controller do

   let(:my_topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
   let(:sponsored_posts) { my_topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph) }


  describe "GET #show" do
    it "returns http success" do
      get :show, params: { topic_id: my_topic.id }
      expect(response).to have_http_status(:success)
    end
  end

  # describe "GET #new" do
  #   it "returns http success" do
  #     get :new
  #     expect(response).to have_http_status(:success)
  #   end
  # end

  # describe "GET #edit" do
  #   it "returns http success" do
  #     get :edit
  #     expect(response).to have_http_status(:success)
  #   end
  # end

end
