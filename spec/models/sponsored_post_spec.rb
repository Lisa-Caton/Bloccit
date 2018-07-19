require 'rails_helper'

RSpec.describe SponsoredPost, type: :model do
 #  let(:title) { RandomData.random_sentence }
 #  let(:body) { RandomData.random_paragraph }
 # let(:topic) { Topic.create!(name: name, description: description) }
 # let(:sponsored_posts) { topic.sponsored_posts.create!(title: title, body: body, price: number_field) }
 #  it { is_expected.to belong_to(:topic) }

 let (:sponsored_posts) { SponsoredPost.create! }

  describe "attributes" do
    it "should respond to title" do
      expect(sponsored_posts).to respond_to(:title)
    end

    it "should respond to body" do
      expect(sponsored_posts).to respond_to(:body)
    end

    it "should respond to price" do
      expect(sponsored_posts).to respond_to(:price)
    end
  end
end
