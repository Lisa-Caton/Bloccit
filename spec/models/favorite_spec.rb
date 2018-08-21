require 'rails_helper'

RSpec.describe Favorite, type: :model do

  let(:topic) { create(:topic) }
  let(:user) { create(:user) }
  let(:post) { create(:post) }
  # These use a Factory for each topic, user, and post!

  let(:favorite) { Favorite.create!(post: post, user: user) }
  # favorite creates an associated to post, and user

  # Shoulda Tests
  it { is_expected.to belong_to(:post) }
  it { is_expected.to belong_to(:user) }
  # test that a favorite belongs to a post and user

end
