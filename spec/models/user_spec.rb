require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { create(:user) }

#Shoulda Tests:

   it { is_expected.to have_many(:posts) }
   # we'll need to associate the Post and User models

   it { is_expected.to have_many(:comments) }
   it { is_expected.to have_many(:votes) }
   it { is_expected.to have_many(:favorites) }

    # Shoulda tests for name
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(1) }

    # Shoulda tests for email
    it { is_expected.to validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    it { is_expected.to validate_length_of(:email).is_at_least(3) }
    it { is_expected.to allow_value("user@bloccit.com").for(:email) }


    # Shoulda tests for password
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }

    describe "attributes" do
      it "should have name and email attributes" do
        expect(user).to have_attributes(name: user.name, email: user.email)
      end

      it "should have each first letter capitalized in the name" do
        user.name = "bloccit user"
        user.save
        expect(user.name).to eq "Bloccit User"
      end

     it "responds to role" do
       expect(user).to respond_to(:role)
     end


     it "responds to admin?" do
       expect(user).to respond_to(:admin?)
     end


     it "responds to member?" do
       expect(user).to respond_to(:member?)
     end


    it "responds to moderator?" do
       expect(user).to respond_to(:moderator?)
     end
   end

  describe "roles" do
     it "is member by default" do
       expect(user.role).to eql("member")
     end

     context "member user" do
       it "returns true for #member?" do
         expect(user.member?).to be_truthy
       end

       it "returns false for #admin?" do
         expect(user.admin?).to be_falsey
       end

       it "returns false for #moderator?" do
         expect(user.moderator?).to be_falsey
       end
     end

     context "admin user" do
       before do
         user.admin!
       end

       it "returns false for #member?" do
         expect(user.member?).to be_falsey
       end

       it "returns true for #admin?" do
         expect(user.admin?).to be_truthy
       end

      it "returns false for #moderator?" do
         expect(user.moderator?).to be_falsey
       end
     end

     context "moderator user" do
       before do
         user.moderator!
       end

       it "returns true for #member?" do
         expect(user.member?).to be_falsey
       end

       it "returns false for #admin?" do
         expect(user.admin?).to be_falsey
       end

      it "returns false for #moderator?" do
         expect(user.moderator?).to be_truthy
       end
     end
  end # end describe


  describe "invalid user" do
    let(:user_with_invalid_name) { build(:user, name: "") }
    let(:user_with_invalid_email) { build(:user, email: "") }

    it "should be an invalid user due to blank name" do
      expect(user_with_invalid_name).to_not be_valid
    end

    it "should be an invalid user due to blank email" do
      expect(user_with_invalid_email).to_not be_valid
    end
  end

  describe "#favorite_for(post)" do
     before do
       topic = Topic.create!(name: RandomData.random_sentence, description: RandomData.random_paragraph)
       @post = topic.posts.create!(title: RandomData.random_sentence, body: RandomData.random_paragraph, user: user)
     end

     it "returns `nil` if the user has not favorited the post" do
       # we expect that favorite_for will return nil if the user has not favorited  @post.
       expect(user.favorite_for(@post)).to be_nil
     end

     it "returns the appropriate favorite if it exists" do
       # we create a favorite for user and @post.
       favorite = user.favorites.where(post: @post).create

       # we expect that favorite_for will return the favorite we created in the line before.
       expect(user.favorite_for(@post)).to eq(favorite)
     end
   end

   describe ".avatar_url" do
    # We use . in describe ".avatar_url" because it is a class method and that is the RSpec convention.
    # RSpec conventions like this make it much easier to troubleshoot tests.

     let(:known_user) { create(:user, email: "blochead@bloc.io") }
    # we build a user with FactoryBot. We pass email: "blochead@bloc.io" to  build, which overrides the email address that would be generated in the factory with "blochead@bloc.io".
    # We are overriding the default email address with a known one so that we can test against a
    # specific string that we know Gravatar will return for the account "blochead@bloc.io".

     it "returns the proper Gravatar url for a known email entity" do
    # we set the expected string that Gravatar should return for "blochead@bloc.io".
    # The s=48 query paramter specifies that we want the returned image to be 48x48 pixels.

       expected_gravatar = "http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48"

       expect(known_user.avatar_url(48)).to eq(expected_gravatar)
       # we expect known_user.avatar_url to return  http://gravatar.com/avatar/bb6d1172212c180cfbdb7039129d7b03.png?s=48.
     end
   end

   describe "#has_posts" do
    it "returns false if the user doesn't have associated posts" do
      expect(user.has_posts?).to eq false
    end

    it "returns true if the user has associated posts" do
      user.posts << build(:post, user: user)
      expect(user.has_posts?).to eq true
    end
  end

  describe "#has_comments" do
    it "returns false if the user doesn't have associated comments" do
      expect(user.has_comments?).to eq false
    end

    it "returns true if the user has associated comments" do
      user.posts << build(:post, user: user)
      user.posts.first.comments << build(:comment, user: user)
      expect(user.has_comments?).to eq true
    end
  end

  describe "#has_favorites" do
    it "returns false if the user doesn't have associated favorites" do
      expect(user.has_favorites?).to eq false
    end

    it "returns true if the user has associated favorites" do
      post = build(:post, user: user)
      user.favorites << Favorite.create!(post: post)
      expect(user.has_favorites?).to eq true
    end
  end


end
