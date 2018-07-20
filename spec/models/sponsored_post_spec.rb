require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do

  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }
  let(:my_sponsored_posts) { topic.sponsored_posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, price: 100) }

  it { is_expected.to belong_to(:topic) }

  describe "attributes" do
    it "should respond to title" do
      expect(my_sponsored_posts).to respond_to(:title)
    end

    it "should respond to body" do
      expect(my_sponsored_posts).to respond_to(:body)
    end

    it "should respond to price" do
      expect(my_sponsored_posts).to respond_to(:price)
    end
  end
end
