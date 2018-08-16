class Post < ApplicationRecord
  belongs_to :topic
  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # We add the comments, votes and favorites association to Post
  # This relates the models and allows us to call post.comments, post.votes, and post.favorites.
  # We also add dependent: ':destroy' to ensure that comments are destroyed when their parent post is deleted.
  # We also add dependent: ':destroy' to ensure that votes are destroyed when their parent post is deleted.
  # We also add dependent: ':destroy' to ensure that favorites are destroyed when their parent post is deleted.
  

  after_create :create_vote
  after_create :create_favorite

  default_scope { order('rank DESC') }
  scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }
  #  unauthenticated users should not be able to see the posts of that user which are associated with private topics.
  # we've created a visible_to scope on Post that returns all the posts whose topics are visible to the given user.
  # we use a lambda (->) to ensure that a user is present or signed in. If the user is present, we return all posts
  # If not, we use the Active Record joins method to retrieve all posts which belong to a public topic.

  scope :ordered_by_title, -> { order('title DESC') }
  scope :ordered_by_reverse_created_at, -> { order('created_at ASC') }

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :topic, presence: true
  validates :user, presence: true


  # Remember that 'votes' is an implied self.votes

  def up_votes
     # we find the up votes for a post by passing value: 1 to where. This fetches a collection of votes with a value of 1. 
     # We then call count on the collection to get a total of all up votes.
     votes.where(value: 1).count
   end
 
   def down_votes
     # we find the down votes for a post by passing value: -1 to where.  where(value: -1) fetches only the votes with a value of -1. 
     # We then call count on the collection to get a total of all up votes.
     votes.where(value: -1).count
   end
 
   def points
     # we use ActiveRecord's 'sum' method to add the value of all the given post's votes. Passing :value to sum tells it what attribute to sum in the collection.
     votes.sum(:value)
   end

   def update_rank
     age_in_days = (created_at - Time.new(1970,1,1)) / 1.day.seconds
     new_rank = points + age_in_days
     update_attribute(:rank, new_rank)
   end

    def create_favorite
      Favorite.create(post: self, user: self.user)
      FavoriteMailer.new_post(self).deliver_now
   end

  private
  def create_vote
    user.votes.create(value: 1, post: self)
   end
end
