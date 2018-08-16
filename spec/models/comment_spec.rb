require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  # These use a Factory for each topic, user, and post!

  let(:comment) { Comment.create!(body: 'Comment Body', post: post, user: user) }
  # comment creates an associated to post, and user

  #Shoulda tests

  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }
  # test that a comment belongs to a post and user

  it { is_expected.to validate_presence_of(:body) }
  it { is_expected.to validate_length_of(:body).is_at_least(5) }
  # test that a comment's body is present and has a minimum length of five

  describe "attributes" do
    it "has a body attribute" do
      expect(comment).to have_attributes(body: "Comment Body")
    end
  end


  # Because we want to send an email every time a user comments on a favorited post, 
  # let's add a callback to Comment.
  describe "after_create" do
     before do
       @another_comment = Comment.new(body: 'Comment Body', post: post, user: user)
       # we initialize (but don't save) a new comment for post
     end
 
     it "sends an email to users who have favorited the post" do
       favorite = user.favorites.create(post: post)
       expect(FavoriteMailer).to receive(:new_comment).with(user, post, @another_comment).and_return(double(deliver_now: true))
       #we favorite post then expect FavoriteMailer will receive a call to  new_comment.

       @another_comment.save!
       # We then save @another_comment to trigger the after create callback.
     end
 
     it "does not send emails to users who haven't favorited the post" do
       expect(FavoriteMailer).not_to receive(:new_comment)
       # test that FavoriteMailer does not receive a call to new_comment when post isn't favorited.
 
       @another_comment.save!
     end
   end
end
