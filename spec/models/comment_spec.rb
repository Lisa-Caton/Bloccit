require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:topic) { Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph) }

  # reflect the new association since comments belong to posts, and we'll now be unable to create posts without a user
  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "helloworld") }
  let(:post) { topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user) }

  let(:comment) { Comment.create!(body: 'Comment Body', post: post, user: user) }
  # create a comment with an associated user

  #Shoulda tests

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }
  # test that a comment belongs to a user and a post

  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(5) }
  # test that a comment's body is present and has a minimum length of five

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: "Comment Body")
    end
  end
end
