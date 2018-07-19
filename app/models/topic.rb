class Topic < ApplicationRecord
  has_many :posts, dependent: :destroy, :sponsored_posts
  # When we delete a topic, its associated posts should also be deleted.
  # Because comments already depend on posts, they will also be deleted when a topic is deleted.

end
