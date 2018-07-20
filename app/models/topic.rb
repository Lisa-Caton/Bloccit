class Topic < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :sponsored_posts, dependent: :destroy
  
  # When we delete a topic, its associated posts should also be deleted.
  # Because comments already depend on posts, they will also be deleted when a topic is deleted.


  validates :name, length: {minimum: 5}, presence: true
  validates :description, length: {minimum: 15}, presence: true
end
