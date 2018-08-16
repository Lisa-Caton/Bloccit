class Topic < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :sponsored_posts, dependent: :destroy
  # We add the posts and sponsored_posts association to Topic
  # This relates the models and allows us to call topic.posts and topic.sponsored_posts
  # We also add dependent: ':destroy' to ensure that posts are destroyed when their parent Topic is deleted.
  # We also add dependent: ':destroy' to ensure that sponsored_posts are destroyed when their parent Topic is deleted.
  # Because comments already depend on posts, they will also be deleted when a topic is deleted.


  validates :name, length: {minimum: 5}, presence: true
  validates :description, length: {minimum: 15}, presence: true
end
