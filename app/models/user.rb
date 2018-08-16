class User < ApplicationRecord
  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  # We add the posts, comments, votes and favorites association to User
  # This relates the models and allows us to call user.posts, user.comments, user.votes and user.favorites
  # We also add dependent: ':destroy' to ensure that posts are destroyed when their parent user is deleted.
  # We also add dependent: ':destroy' to ensure that comments are destroyed when their parent user is deleted.
  # We also add dependent: ':destroy' to ensure that votes are destroyed when their parent user is deleted.
  # We also add dependent: ':destroy' to ensure that favorites are destroyed when their parent user is deleted.

  before_save { self.email = email.downcase if email.present? }
  before_save :format_name
  before_save { self.role ||= :member }

  # Could also have done this (below) instead of 'format_name'
  # before_save { self.name = name.downcase.gsub(/\b\w/, &:upcase) if name.present? }

    validates :name, length: { minimum: 1, maximum: 100 }, presence: true
    
    validates :email,
             presence: true,
             uniqueness: { case_sensitive: false },
             length: { minimum: 3, maximum: 254 }

    validates :password, presence: true, length: { minimum: 6 }, if: -> { "password_digest.nil?" }
    validates :password, length: { minimum: 6 }, allow_blank: true

    has_secure_password

    enum role: [:member, :admin, :moderator]

    def format_name
      if name 
        name_array = []
        name.split.each do |name_part|
          name_array << name_part.capitalize
        end
        self.name = name_array.join(" ")
      end
    end

    def favorite_for(post)
     favorites.where(post_id: post.id).first
   end

   def avatar_url(size)
     gravatar_id = Digest::MD5::hexdigest(self.email).downcase
     "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
   end

end
