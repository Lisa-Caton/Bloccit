require 'rails_helper'

RSpec.describe User, type: :model do

  let(:user) { User.create!(name: "Bloccit User", email: "user@bloccit.com", password: "password") }
    # Shoulda tests for name
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(1) }

    # Shoulda tests for email

    it { is_expected.to validate_presence_of(:email) }

    #UNIQUENESS OF EMAIL (below)
    # it { is_expected.to validate_uniqueness_of(:email) }
    # The matcher wants to create two records, one with an email address of "josiah_koelpin@wiegand.biz", the other with an email of "JOSIAH_KOELPIN@WIEGAND.BIZ". It expects this to work, because if it works, then it means your uniqueness validation is in place. However, because of Devise, the second user's email gets changed to "josiah_koelpin@wiegand.biz". So the matcher actually ends up trying to save two users with the same email address, and that doesn't work, because the uniqueness validation doesn't allow for that. So the matcher fails.

    it { should validate_uniqueness_of(:email).ignoring_case_sensitivity }
    # THIS is the correct way!


    it { is_expected.to validate_length_of(:email).is_at_least(3) }
    it { is_expected.to allow_value("user@bloccit.com").for(:email) }


    # Shoulda tests for password
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to have_secure_password }
    it { is_expected.to validate_length_of(:password).is_at_least(6) }

    describe "attributes" do
      it "should have name and email attributes" do
        expect(user).to have_attributes(name: "Bloccit User", email: "user@bloccit.com")
      end

      it "should have each first letter capitalized in the name" do
        user.name = "bloccit user"
        user.save
        expect(user.name).to eq "Bloccit User"
      end
    end


    describe "invalid user" do
      let(:user_with_invalid_name) { User.new(name: "", email: "user@bloccit.com") }
      let(:user_with_invalid_email) { User.new(name: "Bloccit User", email: "") }

      it "should be an invalid user due to blank name" do
        expect(user_with_invalid_name).to_not be_valid
      end

      it "should be an invalid user due to blank email" do
        expect(user_with_invalid_email).to_not be_valid
      end
    end

  end
